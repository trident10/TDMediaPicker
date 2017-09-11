//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import TDMediaPicker

class Theme6: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0x6C7A89))
        let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x19B5FE), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 15)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x19B5FE), normalTextConfig: TDConfigText.init(text: "Close", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 15)), cornerRadius: 6.0)
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0x19B5FE), textFont: UIFont.init(name: "Palatino-Bold", size: 22)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0x6C7A89))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 80, height: 120)
    }
    
}


