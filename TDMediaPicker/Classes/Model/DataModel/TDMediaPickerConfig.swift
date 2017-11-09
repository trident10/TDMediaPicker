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
    
    static var TDConfigPermissionScreenTheme = permissionTheme()
    
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
    
    static private func navigationTheme()->TDConfigNavigationBar{
        var configNavigationTheme = TDConfigNavigationBar()
        configNavigationTheme.style = UIBarStyle.default
        configNavigationTheme.color = .white
        return configNavigationTheme
    }
    
    static private func permissionTheme()->TDConfigPermissionScreen{
        var config = TDConfigPermissionScreen()
        config.standardView = TDConfigViewStandard.init(backgroundColor: .white)
        
        var cancelBtn = TDConfigButtonText()
        cancelBtn.normalColor = .white
        cancelBtn.disabledColor = .white
        cancelBtn.highlightedColor = .white
        cancelBtn.selectedColor = .white
        
        cancelBtn.normalTextConfig = TDConfigText(text: "Cancel", textColor: .blue, textFont: UIFont.systemFont(ofSize: UIFont.systemFontSize))
        cancelBtn.highlightTextConfig = TDConfigText(text: "Cancel", textColor: .blue, textFont: UIFont.systemFont(ofSize: UIFont.systemFontSize))
        cancelBtn.selectedTextConfig = TDConfigText(text: "Cancel", textColor: .blue, textFont: UIFont.systemFont(ofSize: UIFont.systemFontSize))
        
        config.cancelButton = cancelBtn
        
        return config
        
    }
    
}
