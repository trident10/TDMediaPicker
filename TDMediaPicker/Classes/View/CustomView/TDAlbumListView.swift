//
//  TDAlbumPickerView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDAlbumListViewDelegate: class {
    func albumListView(_ view: TDAlbumListView, didSelectAlbum album: TDAlbumViewModel)
    func albumListViewDidTapBack(_ view: TDAlbumListView)
    func albumListViewDidTapNext(_ view: TDAlbumListView)
}

class TDAlbumListView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Variables
    
    weak var delegate:TDAlbumListViewDelegate?
    
    lazy private var albumListViewModel = TDAlbumListViewModel.init(headerTitle: "Albums")
    private var imageSize: CGSize?

    // MARK: - Outlets
    
    @IBOutlet var tableView:  UITableView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var navigationBar: UIView!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    // MARK: - LifeCycle 
    
    override func awakeFromNib() {
        
    }
    
    // MARK: - Public Method(s)
    
    func setupView(){
        tableView.register(UINib.init(nibName: "TDAlbumCell", bundle: TDMediaUtil.xibBundle()), forCellReuseIdentifier: String(describing: TDAlbumCell.self))
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        self.setupViewModel()
    }
    
    func setupNavigationTheme(_ color: UIColor){
        navigationBar.backgroundColor = color
    }
    
    func setupScreenTitle(_ config: TDConfigLabel){
        TDMediaUtil.setupLabel(titleLable, config: config)
    }
    
    func setupBackButton(_ config: TDConfigButton){
        TDMediaUtil.setupButton(backBtn, buttonConfig: config)
    }
    
    func setupNextButton(_ config: TDConfigButton){
        TDMediaUtil.setupButton(nextBtn, buttonConfig: config)
    }
    
    func setupNextbutton(_ config: TDConfigLabel){
        TDMediaUtil.setupLabel(titleLable, config: config)
    }
    
    func setupAlbumImageSize(_ size: CGSize){
        imageSize = size
    }
    
    func purgeData(){
        albumListViewModel.albums.removeAll()
    }
    
    func reload(_ albums:[TDAlbumViewModel]){
        self.albumListViewModel.albums = albums
        tableView.reloadData()
    }
    
    // MARK: - Private Method(s)
    
    private func setupViewModel(){
        self.titleLable.text = albumListViewModel.headerTitle
    }
    
    // MARK: - IBAction Method(s)
    
    @IBAction func backButtonTapped(button: UIButton){
        self.delegate?.albumListViewDidTapBack(self)
    }
    
    @IBAction func doneButtonTapped(button: UIButton){
        self.delegate?.albumListViewDidTapNext(self)
    }
    
    //MARK: - Table View datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumListViewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TDAlbumCell.self), for: indexPath)
            as! TDAlbumCell
        
        let album = albumListViewModel.albums[(indexPath as NSIndexPath).row]
        
        if imageSize != nil{
            album.imageSize = imageSize!
        }
        if album.image != nil{
            cell.configure(album, image: album.image!)
        }
        else{
            cell.configure(album) { (image) in
                album.image = image
            }
        }
        
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    //MARK: - Table View delegate Method(s)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albumListViewModel.albums[(indexPath as NSIndexPath).row]
        self.delegate?.albumListView(self, didSelectAlbum: album)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TDAlbumCell
        cell.purgeCell()
    }
}
