//
//  TDMediaPickerConfig.swift
//  TDMediaPicker
//
//  Created by Abhimanyu on 27/10/17.
//

import Foundation
import Photos

public struct TDMediaPickerConfig{
    
    public enum AlbumCollectionType: Int {
        case Grid = 1, List = 2
    }
    
    static var defaultMaxSelection = 30
    
    static var defaultNavigationTheme = navigationTheme()
    
    static var defaultAlbumFetchResult = albumFetchResult()
    static var defaultAlbumCollectionType = AlbumCollectionType.List
    
    //static var defaultPermissionConfig =
    
    
    //MARK:- Private Method(s)
    static private func albumFetchResult()->[PHFetchResult<PHAssetCollection>]{
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        return types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
    }
    
    static private func navigationTheme()->TDConfigViewStandard{
        return TDConfigViewStandard.init(backgroundColor: .white)
    }
    
}
