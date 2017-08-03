//
//  TDMediaPreviewThumbView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPreviewThumbViewDelegate: class {
    func previewThumbView(_ view: TDMediaPreviewThumbView, didTapMediaToIndex index: Int)
    func previewThumbViewDidTapAddOption(_ view: TDMediaPreviewThumbView)
}

class TDMediaPreviewThumbView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewThumbViewDelegate?
    
    private var mediaItems:[TDPreviewViewModel] = []
    private var selectedIndex: Int = 0
    
    private let rows: CGFloat = 1
    private let cellSpacing: CGFloat = 2
    
    @IBOutlet var collectionView:  UICollectionView!

    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
    }
    
    
    // MARK: - Public Method(s)
    
    func setupView(){
        TDMediaCell.registerCellWithType(.ImageThumb, collectionView: collectionView)
        TDMediaCell.registerCellWithType(.VideoThumb, collectionView: collectionView)
        TDAddOptionCell.registerCell(collectionView)
    }
    
    func purgeData(){
        mediaItems.removeAll()
    }
    
    func reload(media: TDMediaPreviewViewModel, shouldDisplayAddMoreOption: Bool){
        
        mediaItems.removeAll()
        mediaItems = media.previewMedia
        
        if shouldDisplayAddMoreOption{
            let item = TDPreviewViewModel.init(itemType: .AddOption)
            mediaItems.append(item)
        }
        
        collectionView.reloadData()
    }
    
    func reload(toIndex: Int){
        selectedIndex = toIndex
        //collectionView.reloadData()
        configureFrameViews()
        
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    func getCurrentSelectedIndex()-> Int{
        return selectedIndex
    }
    
    // MARK: - Private Method(s)
    
    
    private func configureFrameViews(){
        for case let cell as TDMediaCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: cell) {
                configureFrameView(cell, indexPath: indexPath)
            }
        }
    }
    
    private func configureFrameView(_ cell: TDMediaCell, indexPath: IndexPath) {
        if selectedIndex ==  (indexPath as NSIndexPath).item{
            cell.processHighlighting(shouldDisplay: true)
        }
        else{
            cell.processHighlighting(shouldDisplay: false)
        }
    }
    
    private func setUpMediaCell(mediaItem: TDPreviewViewModel, indexPath: IndexPath) -> TDMediaCell?{
        if mediaItem.asset?.mediaType == .image{
            return TDMediaCell.mediaCellWithType(.ImageThumb, collectionView: collectionView, for: indexPath)
        }
        if mediaItem.asset?.mediaType == .video{
            return TDMediaCell.mediaCellWithType(.VideoThumb, collectionView: collectionView, for: indexPath)
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
        
        if item.thumbImage != nil{
            cell?.configure(item.thumbImage!)
        }
        else{
            cell?.configure(item.asset!, completionHandler: { (image) in
                item.thumbImage = image
            })
        }
        configureFrameView(cell!, indexPath: indexPath)
        return cell!
    }
    
    private func configureAddOptionCell(item: TDPreviewViewModel, indexPath: IndexPath)-> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TDAddOptionCell.self), for: indexPath)
            as! TDAddOptionCell
        return cell
    }
    
    
    private func getMediaIndex(collectionIndex: Int) -> Int?{
        let items = mediaItems.filter { (item) -> Bool in
            return item.itemType == .Media
        }
        
        let mediaItem = items[collectionIndex]
        
        return items.index(where: { (element) -> Bool in
            return mediaItem === element
        })
        
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
        return configureAddOptionCell(item: item, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.bounds.size.height - (rows - 1) * cellSpacing) / rows
        return CGSize(width: size, height: size)
    }
    
    // MARK: - Collection View Delegate Method(s)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Just to avoid reload on tap of selected cell
        if selectedIndex == indexPath.item{
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            return
        }
        
        let item = mediaItems[(indexPath as NSIndexPath).item]
        
        if item.itemType == .Media{
            let index = indexPath.item
            reload(toIndex: index)
            
            let mediaIndex = getMediaIndex(collectionIndex: index)
            if mediaIndex != nil{
                self.delegate?.previewThumbView(self, didTapMediaToIndex: mediaIndex!)
            }
            return
        }
        if item.itemType == .AddOption{
            self.delegate?.previewThumbViewDidTapAddOption(self)
        }
    }

    // MARK:- Scroll View Delegate Method(s)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        configureFrameViews()
    }
    
}

