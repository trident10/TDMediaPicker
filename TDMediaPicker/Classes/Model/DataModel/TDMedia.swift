//
//  TDMedia.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

open class TDMedia{
    var albumId: String
    var id: String
    open var caption: String = ""
    open let asset: PHAsset
    // MARK: - Initialization
    
    init(albumID: String, asset: PHAsset, caption:String) {
        self.asset = asset
        id = asset.localIdentifier
        self.albumId = albumID
    }
}

