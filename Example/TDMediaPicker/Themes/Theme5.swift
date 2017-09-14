//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by Abhimanu Jindal on 04/09/17.
//  Copyright © 2017 abhimanyujindal10. All rights reserved.
//


import Foundation
import TDMediaPicker

class Theme5: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        
        // View
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0xF5D76E))
        
        // Settings Button
        let buttonSettingsConfig = TDConfigButtonText()
        //Color
        buttonSettingsConfig.normalColor = .clear
        buttonSettingsConfig.highlightedColor = .clear
        //Text
        let butonSettingsTextConfig = TDConfigText(text: "")
        butonSettingsTextConfig.text = "Open Settings"
        butonSettingsTextConfig.textColor = UIColor(rgb: 0xF62459)
        butonSettingsTextConfig.textFont = UIFont.init(name: "BradleyHandITCTT-Bold", size: 25)
        buttonSettingsConfig.normalTextConfig = butonSettingsTextConfig
            
            
        // Cancel Button
        let buttonCancelConfig = TDConfigButtonText()
        //Color
        buttonCancelConfig.normalColor = .clear
        buttonCancelConfig.highlightedColor = .clear
        //Text
        let buttonCancelTextConfig = TDConfigText(text: "")
        buttonCancelTextConfig.text = "Cancel"
        buttonCancelTextConfig.textColor = UIColor(rgb: 0xF62459)
        buttonCancelTextConfig.textFont = UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)
        buttonCancelConfig.normalTextConfig = buttonCancelTextConfig
        
        //Caption Text
        let labelCaptionView = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 24)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        
        let permissionConfig = TDConfigPermissionScreen()
        permissionConfig.standardView = configView
        permissionConfig.settingButton = buttonSettingsConfig
        permissionConfig.cancelButton = buttonCancelConfig
        permissionConfig.caption = labelCaptionView
        

        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0xF5D76E))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 78, height: 78)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        let configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)), cornerRadius: 6.0)
        let nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .lightGray, textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)))
        configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0xF5D76E))
        return configNavBar
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Videos"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n%d",album.collection.localizedTitle!,mediaCount), textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20))
    }

    
}


