//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by Abhimanu Jindal on 04/09/17.
//  Copyright © 2017 abhimanyujindal10. All rights reserved.
//

import Foundation
import TDMediaPicker

class Theme4: ThemeConfig{
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0x6C7A89))
        let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0xF62459), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 15)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0xF62459), normalTextConfig: TDConfigText.init(text: "Close", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 15)), cornerRadius: 6.0)
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 22)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0x6C7A89))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 120, height: 70)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        return TDConfigNavigationBar()
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Selfies"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n\n%d",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.boldSystemFont(ofSize: 20))
    }

}


