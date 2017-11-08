//
//  TDPermissionServiceManager.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

class TDPermissionServiceManager {
    
    // MARK:- Variables
    private var configServiceManager: TDConfigServiceManager = TDConfigServiceManager.sharedInstance
    
    // MARK:- Public Method(s)
    
    func navigationTheme()-> TDViewConfigStandard{
        return configServiceManager.navigationTheme
    }
    
}
