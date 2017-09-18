//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//
import Foundation

open class TDConfigNavigationBar: NSObject{
    
    open var navigationBarView: TDConfigViewStandard?
    open var screenTitle: TDConfigLabel?
    open var backButton: TDConfigButton?
    open var nextButton: TDConfigButton?
    open var otherButton: TDConfigButton?
    
    public init(navigationBarView: TDConfigViewStandard? = nil, screenTitle: TDConfigLabel? = nil, backButton: TDConfigButton? = nil, nextButton: TDConfigButton? = nil, otherButton: TDConfigButton? = nil){
        super.init()
        self.navigationBarView = navigationBarView
        self.screenTitle = screenTitle
        self.backButton = backButton
        self.nextButton = nextButton
        self.otherButton = otherButton
    }
}

