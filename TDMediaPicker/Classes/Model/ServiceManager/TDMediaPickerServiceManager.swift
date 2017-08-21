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
    private var cartServiceManager = TDCartServiceManager.sharedInstance
    private var configServiceManager = TDConfigServiceManager.sharedInstance
    // MARK: - Init
    
    init() {
    }
    
    // MARK: - Public Method(s)
    
    func setupConfig(maxSelections:Int){
        cartServiceManager.setupConfig(maxSelection: maxSelections)
    }
    
    func setupConfig(navigationTheme: TDConfigViewStandard){
        configServiceManager.navigationTheme = navigationTheme
    }
    
    func resetSelectedMedia(){
        cartServiceManager.reset()
    }
    
    func getSelectedMedia()-> [TDMedia]{
        return cartServiceManager.getSelectedMedia()
    }
    
}
