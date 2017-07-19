//
//  TDAlbumPickerView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDAlbumListViewDelegate:class {
    func albumListView(_ view:TDAlbumListView, didSelectAlbum album:TDAlbum)
    func albumListViewDidTapBack(_ view:TDAlbumListView)
    func albumListViewDidTapNext(_ view:TDAlbumListView)
}

class TDAlbumListView1: UIView {
    
}

class TDAlbumListView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Variables
    
    weak var delegate:TDAlbumListViewDelegate?
    
    private var albums:[TDAlbum] = []
    
    // MARK: - Outlets
    
    @IBOutlet var tableView:  UITableView!
    @IBOutlet var titleLable: UILabel!

    
    // MARK: - LifeCycle 
    
    override func awakeFromNib() {
        
    }
    
    // MARK: - Public Method(s)
    
    func setupView(){
        tableView.register(UINib.init(nibName: "TDAlbumCell", bundle: TDMediaUtil.xibBundle()), forCellReuseIdentifier: String(describing: TDAlbumCell.self))

    }
    
    func purgeData(){
        albums.removeAll()
    }
    
    func reload(_ albums:[TDAlbum]){
        self.albums = albums
        tableView.reloadData()
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
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TDAlbumCell.self), for: indexPath)
            as! TDAlbumCell
        
        let album = albums[(indexPath as NSIndexPath).row]
        cell.configure(album)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    //MARK: - Table View delegate Method(s)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[(indexPath as NSIndexPath).row]
        self.delegate?.albumListView(self, didSelectAlbum: album)
    }
}
