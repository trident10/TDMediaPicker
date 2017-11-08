//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//
import Foundation

public struct TDConfigNavigationBar{
    
    public var navigationBarView: TDConfigViewStandard?
    public var screenTitle: TDConfigLabel?
    public var backButton: TDConfigButton?
    public var nextButton: TDConfigButton?
    public var otherButton: TDConfigButton?
    
    public init() {
    }
    
    public init(navigationBarView: TDConfigViewStandard? = nil, screenTitle: TDConfigLabel? = nil, backButton: TDConfigButton? = nil, nextButton: TDConfigButton? = nil, otherButton: TDConfigButton? = nil){
        self.navigationBarView = navigationBarView
        self.screenTitle = screenTitle
        self.backButton = backButton
        self.nextButton = nextButton
        self.otherButton = otherButton
    }
}

