//
//  ViewController+MediaPickerDataSource.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TDMediaPicker
import Photos

extension ViewController: TDMediaPickerDataSource{
    
    //MARK:- Navigation Bar Theme
    
    func mediaPickerNavigationTheme(_ picker: TDMediaPicker) -> TDConfigViewStandard {
        let themeConfig = getThemeConfig()
        return themeConfig.getNavigationThemeConfig()
    }
    
    //MARK:-  Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker) -> TDConfigPermissionScreen {
        let themeConfig = getThemeConfig()
        return themeConfig.getPermissionScreenConfig()
    }
    
    //MARK:- Album Screen
    
    func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let themeConfig = getThemeConfig()
        return themeConfig.getAlbumNavBarConfig()
    }
    
    func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]{
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        return types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
    }
    
    func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPicker.AlbumCollectionType{
        return .List
    }
    
    func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize{
        let themeConfig = getThemeConfig()
        return themeConfig.getImageSizeForAlbum()
    }
    
    func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText{
        let themeConfig = getThemeConfig()
        return themeConfig.getTextFormatForAlbum(album: album, mediaCount: mediaCount)
    }     
    
    func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?{
        let themeConfig = getThemeConfig()
        return themeConfig.getSelectedAlbumAtInitialLoad(albums: albums)
    }
    
    
}


extension ViewController{
    func getThemeConfig()->ThemeConfig{
        switch selectedTheme {
        case .theme1:
            return Theme1()
        case .theme2:
            return Theme2()
        case .theme3:
            return Theme3()
        case .theme4:
            return Theme4()
        case .theme5:
            return Theme5()
        case .theme6:
            return Theme6()
        case .theme7:
            return Theme7()
        }
    }
}
