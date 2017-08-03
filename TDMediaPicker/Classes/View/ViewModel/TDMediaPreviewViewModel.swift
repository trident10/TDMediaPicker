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
    
    enum OperationType {
        case done, close, addMore
    }
    
    
    var previewMedia: [TDPreviewViewModel] = []
    
}


class TDPreviewViewModel{
    
    enum ItemType{
        case Media, AddOption
    }
    
    var itemType:ItemType
    var mainImage: UIImage?
    var thumbImage: UIImage?
    var asset: PHAsset?
    var id: String
    
    init(id:String, asset: PHAsset, itemType: ItemType) {
        self.id = id
        self.asset = asset
        self.itemType = itemType
    }
    
    init(itemType: ItemType) {
        self.id = "-1"
        self.itemType = itemType
    }
}
