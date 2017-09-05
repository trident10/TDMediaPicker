//
//  ViewController+MediaPickerDataSource.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TDMediaPicker

extension ViewController: TDMediaPickerDataSource{
    
    //Navigation Bar Theme
    
    func mediaPickerNavigationTheme(_ picker: TDMediaPicker) -> TDConfigViewStandard {
        let themeConfig = getThemeConfig()
        return themeConfig.getNavigationThemeConfig()
    }
    
    // Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker) -> TDConfigPermissionScreen {
        let themeConfig = getThemeConfig()
        return themeConfig.getPermissionScreenConfig()
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
