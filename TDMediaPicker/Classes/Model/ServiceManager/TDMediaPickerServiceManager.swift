//
//  TDMediaPickerServiceManager.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 29/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation

protocol TDMediaPickerServiceManagerDelegate: class {
    
}

class TDMediaPickerServiceManager{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPickerServiceManagerDelegate?
    fileprivate var cartServiceManager = TDCartServiceManager.sharedInstance
    fileprivate var configServiceManager = TDConfigServiceManager.sharedInstance
    // MARK: - Init
    
    init() {
    }
    
    // MARK: - Public Method(s)
    
    func resetSelectedMedia(){
        cartServiceManager.reset()
    }
    
    func getSelectedMedia()-> [TDMedia]{
        return cartServiceManager.getSelectedMedia()
    }
    
}

// MARK: - Configurations

extension TDMediaPickerServiceManager{
    
    func setupConfig(maxSelections:Int){
        cartServiceManager.maxSelection = maxSelections
    }
    
    func setupConfig(navigationTheme: TDConfigViewStandard){
        configServiceManager.navigationTheme = navigationTheme
    }
    
    func setupConfig(albumScreen: TDConfigAlbumScreen){
        configServiceManager.albumScreenConfig = albumScreen
    }
    
    func setupConfig(mediaScreen: TDConfigMediaScreen){
        configServiceManager.mediaScreenConfig = mediaScreen
    }
    
    func setupConfig(previewScreen: TDConfigPreviewScreen){
        configServiceManager.previewScreenConfig = previewScreen
    }
}
