//
//  TDPermissionServiceManager.swift
//  Pods
//
//  Created by Yapapp on 17/08/17.
//
//

import Foundation

class TDPermissionServiceManager {
    
    // MARK:- Variables
    private var configServiceManager: TDConfigServiceManager = TDConfigServiceManager.sharedInstance
    
    // MARK:- Public Method(s)
    
    func navigationTheme()-> TDConfigViewStandard{
        return configServiceManager.navigationTheme
    }
    
}
