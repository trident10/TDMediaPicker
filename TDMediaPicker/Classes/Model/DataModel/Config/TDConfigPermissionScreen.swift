//
//  TDConfigPermissionScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

public struct TDConfigPermissionScreen{
    
    public var customView: TDConfigView?
    public var standardView: TDConfigView?
    public var caption: TDConfigLabel?
    public var settingButton: TDConfigButton?
    public var cancelButton: TDConfigButton?
    
    public init(customView: TDConfigViewCustom){
        self.customView = customView
    }
    
    public init(standardView: TDConfigViewStandard? = nil, caption: TDConfigLabel? = nil, settingButton: TDConfigButton? = nil, cancelButton: TDConfigButton? = nil){
        self.standardView = standardView
        self.caption = caption
        self.settingButton = settingButton
        self.cancelButton = cancelButton
    }
}
