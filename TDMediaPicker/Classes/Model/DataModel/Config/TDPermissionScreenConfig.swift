//
//  TDConfigPermissionScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

open struct TDPermissionScreenConfig{
    
    open var customView: TDViewConfig?
    open var standardView: TDViewConfig?
    open var caption: TDLabelConfig?
    open var settingButton: TDButtonConfig?
    open var cancelButton: TDButtonConfig?
    
    public init(customView: TDViewConfigCustom){
        super.init()
        self.customView = customView
    }
    
    public init(standardView: TDViewConfigStandard? = nil, caption: TDLabelConfig? = nil, settingButton: TDButtonConfig? = nil, cancelButton: TDButtonConfig? = nil){
        super.init()
        self.standardView = standardView
        self.caption = caption
        self.settingButton = settingButton
        self.cancelButton = cancelButton
    }
}
