//
//  TDAlbum.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

class TDAlbum{
    let collection: PHAssetCollection
    var itemsCount: Int = 0
    var albumMedia: TDMedia?
    var id: String
    
    // MARK: - Initialization
    
    init(collection: PHAssetCollection) {
        self.collection = collection
        self.id = collection.localIdentifier
    }
    
    // MARK: - Public Method(s)
    
    func reload() {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let itemsFetchResult = PHAsset.fetchAssets(in: collection, options: options)
        itemsCount = itemsFetchResult.count
        
        if itemsFetchResult.count > 0{
            albumMedia = TDMedia(asset: itemsFetchResult[0], caption: "")

        }
    }
}
