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
        case done, close, addMore, delete, edit
    }
    
    
    var previewMedia: [TDPreviewViewModel] = []
    
}


class TDPreviewViewModel{
    
    enum ItemType{
        case Media, AddOption
    }
    
    var caption:String?
    var itemType:ItemType
    var mainImage: UIImage?
    var thumbImage: UIImage?
    var asset: PHAsset?
    var id: String
    
    init(id:String, asset: PHAsset, itemType: ItemType, caption: String) {
        self.id = id
        self.asset = asset
        self.itemType = itemType
        self.caption = caption
    }
    
    init(itemType: ItemType) {
        self.id = "-1"
        self.itemType = itemType
    }
}
