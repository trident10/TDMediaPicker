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

private class CollectionItem{
    enum ItemType{
        case Media, AddOption
    }
    
    var type:ItemType
    var data:AnyObject
    
    init(type: ItemType, data: AnyObject) {
        self.type = type
        self.data = data
    }
}

class TDMediaPreviewMainView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewMainViewDelegate?
    
    private var collectionItems:[CollectionItem] = []
    private var selectedIndex: Int = 0
    
    private let rows: CGFloat = 1
    private let cellSpacing: CGFloat = 2
    
    @IBOutlet var collectionView:  UICollectionView!

    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
    }
    
    
    // MARK: - Public Method(s)
    
    func setupView(){
        TDMediaCell.registerCellWithType(.Image, collectionView: collectionView)
        TDMediaCell.registerCellWithType(.Video, collectionView: collectionView)
    }
    
    func purgeData(){
        collectionItems.removeAll()
    }
    
    func reload(cartItems: [TDMedia], updateType: TDCart.UpdateType){
        
        collectionItems.removeAll()
        
        for (_, media) in cartItems.enumerated(){
            let item = CollectionItem.init(type: .Media, data: media as AnyObject)
            collectionItems.append(item)
        }
        
        collectionView.reloadData()
    }
    
    
    func reload(toIndex: Int){
        selectedIndex = toIndex
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: false)
    }
    
    // MARK: - Private Method(s)
    
    private func setUpMediaCell(mediaItem: TDMedia, indexPath: IndexPath) -> TDMediaCell?{
        if mediaItem.asset.mediaType == .image{
            return TDMediaCell.mediaCellWithType(.Image, collectionView: collectionView, for: indexPath)
        }
        if mediaItem.asset.mediaType == .video{
            return TDMediaCell.mediaCellWithType(.Video, collectionView: collectionView, for: indexPath)
        }
        return nil
    }

    private func configureMediaCell(item: CollectionItem, indexPath: IndexPath)-> UICollectionViewCell{
        
        let cell: TDMediaCell?
        let media = item.data as! TDMedia
        cell = setUpMediaCell(mediaItem: media, indexPath: indexPath)
        
        if cell == nil{
            print("ERROR IN GENERATING CORRECT CELL")
            return UICollectionViewCell()
        }
        
        cell?.configure(media.asset)
        return cell!
    }
    
    // MARK: - Collection View Datasource Method(s)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionItems[(indexPath as NSIndexPath).item]

        if item.type == .Media{
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
        
        let item = collectionItems[(indexPath as NSIndexPath).item]
        
        if item.type == .Media{
            let index = indexPath.item
            reload(toIndex: index)
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        let mediaCell = cell as! TDMediaCell
        mediaCell.didEndDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        let mediaCell = cell as! TDMediaCell
        mediaCell.willInitiateDisplay()
    }

    
    
    // MARK: - ScrollView Delegate Method(s)
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        self.delegate?.previewMainView(self, didDisplayViewAtIndex: visibleIndexPath.item)
    }
    
}

