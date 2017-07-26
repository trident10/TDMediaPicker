//
//  TDMediaPreviewViewModel.swift
//  Pods
//
//  Created by Abhimanu Jindal on 26/07/17.
//
//

import Foundation
import Photos

class TDMediaPreviewViewModel{
    
    var previewMedia: [TDMediaViewModel] = []
    
}


class TDPreviewViewModel{
    
    var mainImage: UIImage?
    var thumbImage: UIImage?
    var asset: PHAsset
    var id: String
    
    init(id:String, asset: PHAsset) {
        self.id = id
        self.asset = asset
    }
}
