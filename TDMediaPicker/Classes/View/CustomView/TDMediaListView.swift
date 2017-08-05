//
//  TDMediaListView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaListViewDelegate:class {
    func mediaListView(_ view:TDMediaListView, didSelectMedia media:TDMediaViewModel, shouldRemoveFromCart value: Bool)
    func mediaListViewDidTapBack(_ view:TDMediaListView)
    func mediaListViewDidTapDone(_ view:TDMediaListView)
}


class TDMediaListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Variables
    
    weak var delegate:TDMediaListViewDelegate?
    
    private let columns: CGFloat = 4
    private let cellSpacing: CGFloat = 2
    
    private var mediaItems:[TDMediaViewModel] = []
    private var _cart: TDCartViewModel? = TDCartViewModel(media: [])
    var cart: TDCartViewModel?{
        get{
            return _cart
        }
        set{
            _cart = newValue
            if self.cart?.media.count == 0{
                self.doneButton.isEnabled = false
            }else{
                self.doneButton.isEnabled = true
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet var collectionView:  UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
    }
    
    // MARK: - Public Method(s)
    
    func setupView(){
        TDMediaCell.registerCellWithType(.ImageThumb, collectionView: collectionView)
        TDMediaCell.registerCellWithType(.VideoThumb, collectionView: collectionView)
    }
    
    func purgeData(){
        mediaItems.removeAll()
        cart?.media.removeAll()
    }
    
    func reload(media:[TDMediaViewModel]){
        mediaItems = media
        collectionView.reloadData()
    }
    
    func reload(cart: TDCartViewModel, updateType: TDCartViewModel.UpdateType){
        self.cart = cart
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
    
    private func setUpMediaCell(mediaItem: TDMediaViewModel, indexPath: IndexPath) -> TDMediaCell?{
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
        if mediaItems.count <= (indexPath as NSIndexPath).item{
            return
        }
        let item = mediaItems[(indexPath as NSIndexPath).item]
        
        if let index = cart?.media.index(where: { (element) -> Bool in
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
        
        if item.image != nil{
            cell?.configure(item.image!)
        }
        else{
            cell?.configure(item.asset, completionHandler: { (image) in
                item.image = image
            })
        }
        
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

        let index = cart?.media.index(where: { (element) -> Bool in
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
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let mediaCell = cell as! TDMediaCell
        mediaCell.didEndDisplay()
    }

    
}
