//
//  TDConfigPermissionScreen.swift
//  Pods
//
//  Created by Yapapp on 17/08/17.
//
//

import Foundation

open class TDConfigPermissionScreen: NSObject{
    
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
