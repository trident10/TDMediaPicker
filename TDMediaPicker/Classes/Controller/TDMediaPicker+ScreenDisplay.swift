//
//  TDMediaPicker+ScreenDisplay.swift
//  TDMediaPicker
//
//  Created by Abhimanyu on 06/11/17.
//

import Foundation

//MARK:- SCREEN DISPLAY METHOD(S)
extension TDMediaPicker{
    
    func showPickerScreen(){
        navVC.setNavigationBarHidden(false, animated: false)
        setupScreen(.Album)
        navVC.setViewControllers([albumListVC!], animated: false)
    }
    
    func showPermissionScreen(){
        navVC.setNavigationBarHidden(true, animated: false)
        setupScreen(.Permission)
        navVC.setViewControllers([permissionVC!], animated: false)
    }
    
    func showPreviewScreen(){
        
    }
    
}
