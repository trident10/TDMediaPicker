//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation
import TDMediaPicker

class Theme3: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0xFCC9B9))
        let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x19B5FE), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 16)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0xC91F37), normalTextConfig: TDConfigText.init(text: "Close", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 15)), cornerRadius: 6.0)
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0x003171), textFont: UIFont.boldSystemFont(ofSize: 20)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0xFCC9B9))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 20, height: 20)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        return TDConfigNavigationBar()
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Panoramas"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@ (%d)",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.systemFont(ofSize: 16))
    }

    
}


