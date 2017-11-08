//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation
import Photos

struct TDConfigAlbumScreen{
    
    var navigationBar: TDConfigNavigationBar?
    var fetchResults: [PHFetchResult<PHAssetCollection>]?
    var collectionType: TDMediaPickerConfig.AlbumCollectionType?
    var imageSize: CGSize?
    var selectedInitialAlbum: TDAlbum?
    var mediaType: PHAssetMediaType?
    
}
