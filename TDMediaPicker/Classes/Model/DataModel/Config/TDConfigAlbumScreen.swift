//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by Yapapp on 07/09/17.
//
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
