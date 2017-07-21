//
//  TDAlbumListViewModel.swift
//  Pods
//
//  Created by Abhimanu Jindal on 21/07/17.
//
//

import Foundation
import Photos

class TDAlbumListViewModel{
    
    var headerTitle: String
    var albums: [TDAlbumViewModel] = []
    
    init(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
}

class TDAlbumViewModel{
    
    var title: String
    var countTitle: String
    var image: UIImage?
    var asset: PHAsset
    var id: String
    
    init(id:String, asset: PHAsset, title: String, countTitle: String) {
        self.id = id
        self.asset = asset
        self.title = title
        self.countTitle = countTitle
    }
}
