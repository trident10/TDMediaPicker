//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by Yapapp on 07/09/17.
//
//
import Foundation

open class TDConfigNavigationBar: NSObject{
    
    open var navigationBarView: TDConfigViewStandard?
    open var screenTitle: TDConfigLabel?
    open var backButton: TDConfigButton?
    open var nextButton: TDConfigButton?
    
    public init(navigationBarView: TDConfigViewStandard? = nil, screenTitle: TDConfigLabel? = nil, backButton: TDConfigButton? = nil, nextButton: TDConfigButton? = nil){
        super.init()
        self.navigationBarView = navigationBarView
        self.screenTitle = screenTitle
        self.backButton = backButton
        self.nextButton = nextButton
    }
}

