//
//  TDConfigPermissionScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

open struct TDPermissionScreenConfig{
    
    open var customView: TDConfigView?
    open var standardView: TDConfigView?
    open var caption: TDConfigLabel?
    open var settingButton: TDConfigButton?
    open var cancelButton: TDConfigButton?
    
    public init(customView: TDConfigViewCustom){
        super.init()
        self.customView = customView
    }
    
    public init(standardView: TDConfigViewStandard? = nil, caption: TDConfigLabel? = nil, settingButton: TDConfigButton? = nil, cancelButton: TDConfigButton? = nil){
        super.init()
        self.standardView = standardView
        self.caption = caption
        self.settingButton = settingButton
        self.cancelButton = cancelButton
    }
}
