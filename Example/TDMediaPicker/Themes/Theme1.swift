//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import TDMediaPicker

class Theme1: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: .lightGray)
        let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0xD24D57), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "close"), customSize: CGSize.init(width: 20, height: 20))
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0xF62459), textFont: UIFont.boldSystemFont(ofSize: 20)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: .lightGray)
    }

}


