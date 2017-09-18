//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation
import TDMediaPicker

class Theme2: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0x89C4F4))
        let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x5B3256), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: UIColor(rgb: 0x5F5D76E), textFont: UIFont.boldSystemFont(ofSize: 16)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x5B3256), normalTextConfig: TDConfigText.init(text: "Close", textColor: UIColor(rgb: 0xF5D76E), textFont: UIFont.boldSystemFont(ofSize: 15)), cornerRadius: 6.0)
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0x5B3256), textFont: UIFont.init(name: "Arial", size: 22)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0x89C4F4))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 50, height: 70)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        return TDConfigNavigationBar()
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Recently Added"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n\n%d",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.systemFont(ofSize: 16))
    }
    
    override func getMediaHighlightedCellView(mediaCount: Int)->TDConfigView{
        return TDConfigViewStandard(backgroundColor: .red)
    }
    
    
    override func getNumberOfColumnInPortrait()->Int{
        return 3
    }
    
    override func getNumberOfColumnInLandscape()->Int{
        return 7
    }
}


