//
//  TDAlbum.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

public struct TDAlbum{
    
    public let collection: PHAssetCollection
    public private(set) var itemsCount: Int = 0
    public private(set) var albumMedia: TDMedia?
    public private(set) var id: String
    
    // MARK: - Initialization
    
    init(collection: PHAssetCollection) {
        self.collection = collection
        self.id = collection.localIdentifier
    }
    
    // MARK: - Public Method(s)
    
    mutating func reload(filteredMediaType:PHAssetMediaType?) {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let itemsFetchResult = PHAsset.fetchAssets(in: collection, options: options)
        itemsCount = itemsFetchResult.count
        
        if itemsFetchResult.count > 0{
            if filteredMediaType != nil && filteredMediaType != itemsFetchResult.firstObject?.mediaType{
                itemsCount = 0
                return
            }
            albumMedia = TDMedia(albumID: self.id, asset: itemsFetchResult[0], caption: "")

        }
    }
}
