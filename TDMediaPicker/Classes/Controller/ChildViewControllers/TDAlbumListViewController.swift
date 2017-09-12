//
//  TDAlbumPickerViewController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

protocol TDAlbumListViewControllerDataSource: class{
    func albumController(_ controller: TDAlbumListViewController, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?
    func albumController(_ picker: TDAlbumListViewController, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText
}

protocol TDAlbumListViewControllerDelegate: class{
    func albumControllerDidTapCancel(_ controller: TDAlbumListViewController)
    func albumControllerDidTapDone(_ controller: TDAlbumListViewController)
    func albumController(_ controller: TDAlbumListViewController, didSelectAlbum album: TDAlbum, animation:Bool)
}

class TDAlbumListViewController: UIViewController, TDAlbumListViewDelegate, TDAlbumListServiceManagerDelegate, TDAlbumListViewDataSource{
    
    // MARK: - Variables
    weak var delegate: TDAlbumListViewControllerDelegate?
    weak var datasource: TDAlbumListViewControllerDataSource?
    
    lazy fileprivate var serviceManager: TDAlbumListServiceManager = TDAlbumListServiceManager()
    lazy fileprivate var isFirstTime = false
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
        albumView.dataSource = self
        
        // 3. Service Manager Setup
        serviceManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationTheme()
        setupConfig()
        serviceManager.fetchAlbums(getAlbumFetchResults()) { (albums) in
            
            
            self.handleFetchedAlbums(albums)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        serviceManager.purgeData()
        
        let albumView = self.view as! TDAlbumListView
        albumView.purgeData()
    }
    
    // MARK: - Private Method(s)
    private func handleFetchedAlbums(_ albums:[TDAlbum]){
        if !isFirstTime{
            isFirstTime = true
            if let selectedInitialAlbum = self.datasource?.albumController(self, selectedAlbumAtInitialLoad: albums){
                self.delegate?.albumController(self, didSelectAlbum: selectedInitialAlbum, animation: false)
            }
        }
        
        var albumViewModels: [TDAlbumViewModel] = []
        for(_,album) in albums.enumerated(){
            let albumViewModel = map(album)
            if albumViewModel != nil{
                let albumView = albumViewModel as! TDAlbumViewModel
                albumViewModels.append(albumView)
            }
        }
        let albumView = self.view as! TDAlbumListView
        albumView.reload(albumViewModels)
    }
    
    private func map<T>(_ from: T) -> AnyObject?{
        if from is TDAlbum{
            let album = from as! TDAlbum
            
            var title = ""
            if album.collection.localizedTitle != nil{
                title = album.collection.localizedTitle!
            }
            
            let countText = "\(album.itemsCount)"
            let asset = album.albumMedia?.asset
            let imageSize = CGSize(width: 65, height: 65)
            
            if asset != nil{
                return TDAlbumViewModel.init(id: album.id, asset: asset!, title: title, countTitle: countText, imageSize: imageSize) as AnyObject
            }
        }
        return nil
    }
    
    //MARK: - Album View Datasource Method(s)
    
    func albumListView(_ view: TDAlbumListView, textForAlbum album: TDAlbumViewModel)->TDConfigText?{
        let albums = serviceManager.fetchAlbum(album.id)
        let selectedAlbum: TDAlbum?
        if albums.count > 0{
            selectedAlbum = albums[0]
        }
        else{
            return nil
        }
        
        let currentCount = selectedAlbum?.itemsCount
        
        return self.datasource?.albumController(self, textFormatForAlbum: selectedAlbum!, mediaCount: currentCount!)
    }
    
    // MARK: - Album View Delegate Method(s)
    
    func albumListView(_ view:TDAlbumListView, didSelectAlbum album:TDAlbumViewModel){
        serviceManager.fetchAlbum(album.id, completion: { (albumData) in
            if albumData != nil{
                self.delegate?.albumController(self, didSelectAlbum: albumData!, animation: true)
            }
        })
    }
    
    func albumListViewDidTapBack(_ view:TDAlbumListView){
        self.delegate?.albumControllerDidTapCancel(self)
    }
    
    func albumListViewDidTapNext(_ view:TDAlbumListView){
        self.delegate?.albumControllerDidTapDone(self)
    }
    
}


// MARK: - Configurations

extension TDAlbumListViewController{
    
    func setupNavigationTheme(){
        let config = serviceManager.getNavigationThemeConfig()
        let albumView = self.view as! TDAlbumListView
        albumView.setupNavigationTheme(config.backgroundColor)
    }
    
    func setupConfig(){
        let albumView = self.view as! TDAlbumListView
        let config = serviceManager.getAlbumScreenConfig()
        
        if let title = config.navigationBar?.screenTitle{
            albumView.setupScreenTitle(title)
        }
        if let btnConfig = config.navigationBar?.backButton{
            albumView.setupBackButton(btnConfig)
        }
        if let btnConfig = config.navigationBar?.nextButton{
            albumView.setupNextButton(btnConfig)
        }
        if let color = config.navigationBar?.navigationBarView?.backgroundColor{
            albumView.setupNavigationTheme(color)
        }
        if let size = config.imageSize{
            albumView.setupAlbumImageSize(size)
        }
    }
    
    func getAlbumFetchResults()->[PHFetchResult<PHAssetCollection>]?{
        let config = serviceManager.getAlbumScreenConfig()
        return config.fetchResults
    }
    
}



