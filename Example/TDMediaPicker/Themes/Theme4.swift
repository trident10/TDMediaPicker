//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import TDMediaPicker

class Theme4: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        //1.
        //let view = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        //view.backgroundColor = .red
        //let configView = TDConfigViewCustom(view: view)
        
        //2.
        //let configView = TDConfigViewStandard(backgroundColor: .blue)
        //let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        //3.
        let permissionConfig = TDConfigPermissionScreen()
        permissionConfig.settingButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "scan_qr_button"), customSize: CGSize.init(width: 32, height: 32))
        //TDConfigButtonText.init(normalColor: .red, normalTextConfig: TDConfigText.init(text: "Settings", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "close"), customSize: CGSize.init(width: 16, height: 16))
        
        //4.
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "1. Please give access to photo library. 2. Please give access to photo library. 3. Please give access to photo library. 4. Please give access to photo library. 5. Please give access to photo library. 6. Please give access to photo library. 7. Please give access to photo library.", textColor: .black, textFont: UIFont.boldSystemFont(ofSize: 20)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        
        //TDConfigText.init(text: "Please give access to photo library", textColor: .black, textFont: UIFont.boldSystemFont(ofSize: 10))
        return permissionConfig
    }
    
}


