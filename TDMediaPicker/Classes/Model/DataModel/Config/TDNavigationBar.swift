//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//
import Foundation

open struct TDNavigationBarConfig{
    
    open var navigationBarView: TDViewConfigStandard?
    open var screenTitle: TDLabelConfig?
    open var backButton: TDButtonConfig?
    open var nextButton: TDButtonConfig?
    open var otherButton: TDButtonConfig?
    
    public init() {
        super.init()
    }
    
    public init(navigationBarView: TDConfigViewStandard? = nil, screenTitle: TDConfigLabel? = nil, backButton: TDConfigButton? = nil, nextButton: TDConfigButton? = nil, otherButton: TDConfigButton? = nil){
        super.init()
        self.navigationBarView = navigationBarView
        self.screenTitle = screenTitle
        self.backButton = backButton
        self.nextButton = nextButton
        self.otherButton = otherButton
    }
}

