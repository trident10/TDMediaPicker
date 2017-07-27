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
    var id: String
    let asset: PHAsset
    // MARK: - Initialization
    
    init(asset: PHAsset) {
        self.asset = asset
        id = asset.localIdentifier
    }
}

