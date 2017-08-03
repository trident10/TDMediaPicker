//
//  TDMediaPreviewMainView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPreviewMainViewDelegate: class {
    func previewMainView(_ view: TDMediaPreviewMainView, didDisplayViewAtIndex index: Int)
}

class TDMediaPreviewMainView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewMainViewDelegate?
    
    private var mediaItems: [TDPreviewViewModel] = []
    private var selectedIndex: Int = 0
    
    private let rows: CGFloat = 1
    private let cellSpacing: CGFloat = 2
    
    // This logic is used to avoid multiple reload of thumpreview
    private var isScrolledByUser: Bool = true
    private var timer: Timer?
    
    private var currentVisibleIndex = -1
    private var currentPlayerSetupIndex = -1
    
    fileprivate var videoPlayerView: TDMediaVideoView?
    
    @IBOutlet var collectionView:  UICollectionView!

    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
    }
    
    
    // MARK: - Public Method(s)
    
    func setupView(){
        TDMediaCell.registerCellWithType(.Image, collectionView: collectionView)
        TDMediaCell.registerCellWithType(.Video, collectionView: collectionView)
        
        videoPlayerView = TDMediaVideoView(frame: self.bounds)
        videoPlayerView?.delegate = self
    }
    
    func purgeData(){
        mediaItems.removeAll()
        videoPlayerView?.removeFromSuperview()
        videoPlayerView = nil
    }
    
    func reload(media: TDMediaPreviewViewModel){
        
        mediaItems.removeAll()
        mediaItems = media.previewMedia
        
        collectionView.reloadData()
        
        currentVisibleIndex = 0
        selectedIndex = 0
        
        DispatchQueue.main.async {
            self.setupVideoPlayerView()
        }
    }
    
    
    func reload(toIndex: Int){
        
        var shouldScrollAnimated = true
        if abs(selectedIndex - toIndex) > 3{
            shouldScrollAnimated = false
        }
        
        selectedIndex = toIndex
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        
        isScrolledByUser = false
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: shouldScrollAnimated)
        
        if !shouldScrollAnimated{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                self.setupVideoPlayerView()
            })
        }
        
        //TEMP HACK TO AVOID MULTIPLE RELOAD OF THUMB PREVIEW VIEW.
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            self.isScrolledByUser = true
        })
    }
    
    // MARK: - Private Method(s)
    
    private func notifyScrolling(){
        if !isScrolledByUser{
            return
        }
        self.delegate?.previewMainView(self, didDisplayViewAtIndex: currentVisibleIndex)
    }
    
    fileprivate func purgeVideoPlayer(_ completion: @escaping (Void) -> Void){
        videoPlayerView?.removeFromSuperview()
        videoPlayerView?.purgeVideoPlayer {
            completion()
        }
    }
    
    private func setupVideoPlayerView(){
        if currentVisibleIndex == -1 || (currentPlayerSetupIndex != -1 && currentPlayerSetupIndex == currentVisibleIndex){
            // Stop Setup of player
            videoPlayerView?.stopVideo()
            return
        }
        let media = mediaItems[currentVisibleIndex]
        if media.asset?.mediaType == .video{
            let cell = collectionView.cellForItem(at: IndexPath(item: currentVisibleIndex, section: 0))
            if cell != nil{
                currentPlayerSetupIndex = currentVisibleIndex
                purgeVideoPlayer {
                    cell?.addSubview(self.videoPlayerView!)
                    self.videoPlayerView?.setupVideoPlayer(media.asset!, completion: {})
                }
                return
            }
        }
        currentPlayerSetupIndex = -1
        videoPlayerView?.removeFromSuperview()
        videoPlayerView?.purgeVideoPlayer {}
    }
    
    private func updateCurrentVisibleIndex(){
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        currentVisibleIndex = visibleIndexPath.item
    }
    
    private func handleMediaCellActions(cell:TDMediaCell, indexPath: IndexPath){
        cell.onButtonTap { (buttonType) in
            if buttonType == .videoPlay{
                self.videoPlayerView?.isHidden = false
                self.videoPlayerView?.playVideo()
            }
        }
    }
    
    private func setUpMediaCell(mediaItem: TDPreviewViewModel, indexPath: IndexPath) -> TDMediaCell?{
        if mediaItem.asset?.mediaType == .image{
            return TDMediaCell.mediaCellWithType(.Image, collectionView: collectionView, for: indexPath)
        }
        if mediaItem.asset?.mediaType == .video{
            let cell =  TDMediaCell.mediaCellWithType(.Video, collectionView: collectionView, for: indexPath)
            handleMediaCellActions(cell: cell, indexPath: indexPath)
            return cell
        }
        return nil
    }

    private func configureMediaCell(item: TDPreviewViewModel, indexPath: IndexPath)-> UICollectionViewCell{
        
        let cell: TDMediaCell?
        cell = setUpMediaCell(mediaItem: item, indexPath: indexPath)
        
        if cell == nil{
            print("ERROR IN GENERATING CORRECT CELL")
            return UICollectionViewCell()
        }
        
        if item.mainImage != nil{
            cell?.configure(item.mainImage!)
        }
        else{
            cell?.configure(item.asset!, completionHandler: { (image) in
                item.mainImage = image
            })
        }
        
        return cell!
    }
    
    
    
    // MARK: - Collection View Datasource Method(s)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = mediaItems[(indexPath as NSIndexPath).item]
        if item.itemType == .Media{
            return configureMediaCell(item: item, indexPath: indexPath)
        }
        print("THIS SHOULD NOT BE CALLED. CHECK FOR ERROR")
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    // MARK: - Collection View Delegate Method(s)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isScrolledByUser = true
    }
    
    // MARK: - ScrollView Delegate Method(s)
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCurrentVisibleIndex()
        notifyScrolling()
        setupVideoPlayerView()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setupVideoPlayerView()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        setupVideoPlayerView()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setupVideoPlayerView()
    }
}

//MARK: - VideoPlayer Delegate Method(s)

extension TDMediaPreviewMainView: TDMediaVideoViewDelegate{
    
    func videoViewDidStopPlay(_ view: TDMediaVideoView) {
        
    }
    
}

