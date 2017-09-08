//
//  ThemeConfig.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import TDMediaPicker

class ThemeConfig {
    
    func getNavigationThemeConfig()->TDConfigViewStandard{
        fatalError("Concrete class must provide data")
    }
    
    func getPermissionScreenConfig()->TDConfigPermissionScreen{
        fatalError("Concrete class must provide data")
    }
}

