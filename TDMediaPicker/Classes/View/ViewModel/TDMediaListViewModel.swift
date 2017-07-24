//
//  TDMediaListViewModel.swift
//  Pods
//
//  Created by Abhimanu Jindal on 21/07/17.
//
//

import Foundation
import Photos

class TDMediaListViewModel{
    
    var headerTitle: String
    var media: [TDMediaViewModel] = []
    
    init(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
}

class TDMediaViewModel{
    
    var image: UIImage?
    var asset: PHAsset
    var id: String
    
    init(id:String, asset: PHAsset) {
        self.id = id
        self.asset = asset
    }
}

class TDCartViewModel{
    
    enum UpdateType {
        case none
        case add
        case delete
        case reload
        case purgeCache
    }
    
    var media: [TDMediaViewModel] = []
    
    init(media:[TDMediaViewModel]) {
        self.media = media
    }
    
}

