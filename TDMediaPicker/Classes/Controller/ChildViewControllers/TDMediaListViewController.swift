//
//  TDMediaListViewController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaListViewControllerDelegate: class {
    func mediaControllerDidTapDone(_ view: TDMediaListViewController)
    func mediaControllerDidTapCancel(_ view: TDMediaListViewController)
}


class TDMediaListViewController: UIViewController, TDMediaListViewDelegate, TDMediaListServiceManagerDelegate{
    
    // MARK: - Variable(s)
    
    private var selectedAlbum:TDAlbum?

    weak var delegate: TDMediaListViewControllerDelegate?

    
    lazy private var seviceManager: TDMediaListServiceManager = TDMediaListServiceManager()
    
    // MARK: - Init
    
    public required init() {
        super.init(nibName: "TDMediaList", bundle: TDMediaUtil.xibBundle())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 2. View Setup
        
        let mediaView = self.view as! TDMediaListView
        mediaView.setupView()
        mediaView.delegate = self
        
        // 3. Service Manager Setup

        seviceManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if selectedAlbum != nil{
            seviceManager.fetchMediaItems(album: selectedAlbum!)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        seviceManager.purgeData()
        
        let mediaView = self.view as! TDMediaListView
        mediaView.purgeData()
    }
    
    // MARK: - Public Method(s)
    
    func setupSelectedAlbum(_ album:TDAlbum){
        selectedAlbum = album
    }
    
    // MARK: - Private Method(s)
    
    
    
    // MARK: - View Delegate Method(s)
    
    func mediaListView(_ view: TDMediaListView, didSelectMedia media: TDMedia, shouldRemoveFromCart value: Bool) {
        if value{
            seviceManager.removeMediaFromCart(media)
            return
        }
        seviceManager.addMediaToCart(media)
    }
    
    func mediaListViewDidTapBack(_ view: TDMediaListView) {
        self.delegate?.mediaControllerDidTapCancel(self)
    }
    
    func mediaListViewDidTapDone(_ view: TDMediaListView) {
        self.delegate?.mediaControllerDidTapDone(self)
    }
    
    
    // MARK: - Service Manager Delegate Method(s)
    
    func mediaListServiceManager(_ manager: TDMediaListServiceManager, didFetchMedia media: [TDMedia]) {
        let mediaView = self.view as! TDMediaListView
        mediaView.reload(album: selectedAlbum!, mediaItems: media)
    }
    
    func mediaListServiceManager(_ manager: TDMediaListServiceManager, didUpdateCart cart: [TDMedia], updateType: TDCart.UpdateType) {
        
        let mediaView = self.view as! TDMediaListView
        mediaView.reload(album: selectedAlbum!, cartItems: cart, updateType: updateType)
        
    }
    
    
}
