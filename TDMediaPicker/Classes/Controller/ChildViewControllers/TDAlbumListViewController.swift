//
//  TDAlbumPickerViewController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit


protocol TDAlbumListViewControllerDelegate: class{
    func albumControllerDidTapCancel(_ controller: TDAlbumListViewController)
    func albumControllerDidTapDone(_ controller: TDAlbumListViewController)
    func albumController(_ controller: TDAlbumListViewController, didSelectAlbum album: TDAlbum)
}

class TDAlbumListViewController: UIViewController, TDAlbumListViewDelegate, TDAlbumListServiceManagerDelegate{
    
    // MARK: - Variables
    weak var delegate: TDAlbumListViewControllerDelegate?
    
    lazy private var seviceManager: TDAlbumListServiceManager = TDAlbumListServiceManager()
    
    // MARK: - Init
    
    public required init() {
        super.init(nibName: "TDAlbumList", bundle: TDMediaUtil.xibBundle())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. View Setup
        
        let albumView = self.view as! TDAlbumListView
        albumView.setupView()
        albumView.delegate = self
        
        // 3. Service Manager Setup
        seviceManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        seviceManager.fetchAlbums()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        seviceManager.purgeData()
        
        let albumView = self.view as! TDAlbumListView
        albumView.purgeData()
    }
    
    // MARK: - Public Method(s)
    
    
    // MARK: - Album View Delegate Method(s)
    
    func albumListView(_ view:TDAlbumListView, didSelectAlbum album:TDAlbum){
        self.delegate?.albumController(self, didSelectAlbum: album)
    }
    
    func albumListViewDidTapBack(_ view:TDAlbumListView){
        self.delegate?.albumControllerDidTapCancel(self)
    }
    
    func albumListViewDidTapNext(_ view:TDAlbumListView){
        self.delegate?.albumControllerDidTapDone(self)
    }
    
    
    // MARK: - Service Manager Delegate Method(s)
    
    func albumServiceManager(_ manager: TDAlbumListServiceManager, didFetchAlbums albums: [TDAlbum]) {
        
        let albumView = self.view as! TDAlbumListView
        albumView.reload(albums)
    }
    
}

