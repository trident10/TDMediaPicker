//
//  TDMediaListView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaListViewDelegate:class {
    func mediaListView(_ view:TDMediaListView, didSelectMedia media:TDMedia, shouldRemoveFromCart value: Bool)
    func mediaListViewDidTapBack(_ view:TDMediaListView)
    func mediaListViewDidTapDone(_ view:TDMediaListView)
}


class TDMediaListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variables
    
    weak var delegate:TDMediaListViewDelegate?
    
    private let columns: CGFloat = 4
    private let cellSpacing: CGFloat = 2
    
    private var selectedAlbum:TDAlbum?
    private var mediaItems:[TDMedia] = []
    private var cartItems:[TDMedia]?
    
    // MARK: - Outlets
    
    @IBOutlet var collectionView:  UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
    }
    
    // MARK: - Public Method(s)
    
    func setupView(){
        TDMediaCell.registerCellWithType(.ImageThumb, collectionView: collectionView)
        TDMediaCell.registerCellWithType(.VideoThumb, collectionView: collectionView)
    }
    
    func purgeData(){
        selectedAlbum = nil
        mediaItems.removeAll()
        cartItems?.removeAll()
    }
    
    func reload(album: TDAlbum, mediaItems: [TDMedia]){
        selectedAlbum = album
        self.mediaItems = mediaItems
        collectionView.reloadData()
    }
    
    func reload(album: TDAlbum, cartItems: [TDMedia], updateType: TDCart.UpdateType){
        selectedAlbum = album
        self.cartItems = cartItems
        
        switch updateType {
        case .reload:
            collectionView.reloadData()
        default:
            configureFrameViews()
        }
    }
    
    // MARK: - Action Method(s)
    
    @IBAction func backButtonTapped(sender: UIButton){
        self.delegate?.mediaListViewDidTapBack(self)
    }
    
    @IBAction func doneButtonTapped(sender: UIButton){
        self.delegate?.mediaListViewDidTapDone(self)
    }
    
    
    // MARK: - Private Method(s)
    
    private func setUpMediaCell(mediaItem: TDMedia, indexPath: IndexPath) -> TDMediaCell?{
        if mediaItem.asset.mediaType == .image{
            return TDMediaCell.mediaCellWithType(.ImageThumb, collectionView: collectionView, for: indexPath)
        }
        if mediaItem.asset.mediaType == .video{
            return TDMediaCell.mediaCellWithType(.VideoThumb, collectionView: collectionView, for: indexPath)
        }
        return nil
    }
    
    private func configureFrameViews(){
        for case let cell as TDMediaCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: cell) {
                configureFrameView(cell, indexPath: indexPath)
            }
        }
    }
    
    private func configureFrameView(_ cell: TDMediaCell, indexPath: IndexPath) {
        let item = mediaItems[(indexPath as NSIndexPath).item]
        
        if let index = cartItems?.index(where: { (element) -> Bool in
            return element.asset.localIdentifier == item.asset.localIdentifier
        }){
            cell.processHighlighting(shouldDisplay: true, count: index + 1)
        }
        else {
            cell.processHighlighting(shouldDisplay: false)
        }
    }
    
    // MARK: - Collection View Datasource Method(s)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: TDMediaCell?
        let item = mediaItems[(indexPath as NSIndexPath).item]
        
        cell = setUpMediaCell(mediaItem: item, indexPath: indexPath)
        
        if cell == nil{
            print("ERROR IN GENERATING CORRECT CELL")
            return UICollectionViewCell()
        }
        
        cell?.configure(item.asset)
        configureFrameView(cell!, indexPath: indexPath)

        return cell!

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.bounds.size.width - (columns - 1) * cellSpacing) / columns
        return CGSize(width: size, height: size)
    }
    
    // MARK: - Collection View Delegate Method(s)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let media = mediaItems[(indexPath as NSIndexPath).item]

        let index = cartItems?.index(where: { (element) -> Bool in
            return element.asset.localIdentifier == media.asset.localIdentifier
        })
        
        if index != nil
        {
            self.delegate?.mediaListView(self, didSelectMedia: media, shouldRemoveFromCart: true)
        }
        else {
            self.delegate?.mediaListView(self, didSelectMedia: media, shouldRemoveFromCart: false)
        }
    }

    
}
