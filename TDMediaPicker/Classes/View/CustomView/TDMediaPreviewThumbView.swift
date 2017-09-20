//
//  TDMediaPreviewThumbView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
protocol TDMediaPreviewThumbViewDataSource: class {
    func previewThumbViewSelectedThumbnailView(_ view: TDMediaPreviewThumbView)-> TDConfigView?
    func previewThumbViewThumbnailAddView(_ view: TDMediaPreviewThumbView)-> TDConfigView?
    func previewThumbViewVideoThumbOverlay(_ view: TDMediaPreviewThumbView)-> TDConfigView?
}
protocol TDMediaPreviewThumbViewDelegate: class {
    func previewThumbView(_ view: TDMediaPreviewThumbView, didTapMediaToIndex index: Int)
    func previewThumbViewDidTapAddOption(_ view: TDMediaPreviewThumbView)
}

class TDMediaPreviewThumbView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewThumbViewDelegate?
    weak var dataSource: TDMediaPreviewThumbViewDataSource?
    
    private var mediaItems:[TDPreviewViewModel] = []
    private var selectedIndex: Int = 0
    
    private let rows: CGFloat = 1
    private let cellSpacing: CGFloat = 2
    
    @IBOutlet weak var heightPortraitConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightLandscapeConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView:  UICollectionView!

    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
    }
    
    override func layoutSubviews() {
        collectionView.reloadData()
    }
    
    // MARK: - Public Method(s)
    
    func viewDidTransition(){
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    
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
            if let configView = self.dataSource?.previewThumbViewSelectedThumbnailView(self){
                if cell is TDMediaCellImageThumb{
                    TDMediaUtil.setupView((cell as! TDMediaCellImageThumb).selectedView, configView)
                }else{
                    TDMediaUtil.setupView((cell as! TDMediaCellVideoThumb).selectedView, configView)
                }
            }
        }
        else{
            cell.processHighlighting(shouldDisplay: false)
        }
    }
    
    private func setVideoThumbView(_ cell: TDMediaCell){
        if let configView = self.dataSource?.previewThumbViewVideoThumbOverlay(self){
            TDMediaUtil.setupView((cell as! TDMediaCellVideoThumb).viewForVideo, configView)
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
        if let configView = self.dataSource?.previewThumbViewThumbnailAddView(self){
            TDMediaUtil.setupView(cell.selectedView, configView)
        }
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
            let cell = configureMediaCell(item: item, indexPath: indexPath)
            if item.asset?.mediaType == .video{
                setVideoThumbView(cell as! TDMediaCell)
            }
            return cell
        }
        return configureAddOptionCell(item: item, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.bounds.size.height - (rows - 1) * cellSpacing) / rows
        return CGSize(width: size, height: size)
    }
    
    // MARK: - Collection View Delegate Method(s)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let item = mediaItems[(indexPath as NSIndexPath).item]
        
        if item.itemType == .Media{
            
            // Just to avoid reload on tap of selected cell
            if selectedIndex == indexPath.item{
                collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                return
            }
            
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

