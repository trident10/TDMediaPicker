//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation
import Photos

class TDConfigAlbumScreen: NSObject{
    
    var navigationBar: TDConfigNavigationBar?
    var fetchResults: [PHFetchResult<PHAssetCollection>]?
    var collectionType: TDMediaPicker.AlbumCollectionType?
    var imageSize: CGSize?
    var selectedInitialAlbum: TDAlbum?
    
}
