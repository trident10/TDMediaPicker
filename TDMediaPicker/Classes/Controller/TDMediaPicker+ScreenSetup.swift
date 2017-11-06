//
//  TDMediaPicker+ScreenSetup.swift
//  TDMediaPicker
//
//  Created by Abhimanyu on 06/11/17.
//

import UIKit

//MARK:- SCREEN SETUP METHOD(S)
extension TDMediaPicker{
    
    func setupScreen(_ screenType:TDMediaPicker.ScreenType){
        switch screenType {
            
        case .Permission:
            permissionVC = nil
            permissionVC = TDMediaPermissionViewController()
            permissionVC?.delegate = self
            
        case .Album:
            albumListVC = nil
            albumListVC = TDAlbumListViewController()
            albumListVC?.delegate = self
            albumListVC?.dataSource = self
            
        case .Media:
            mediaListVC = nil
            mediaListVC = TDMediaListViewController()
            mediaListVC?.delegate = self
            mediaListVC?.dataSource = self
            
        case .Preview:
            previewVC = nil
            previewVC = TDMediaPreviewViewController()
            previewVC?.delegate = self
            previewVC?.dataSource = self
            
        default:
            print("No Use")
        }
    }
    
    func cleanupScreen(_ screenType:TDMediaPicker.ScreenType){
        switch screenType {
            
        case .Permission:
            permissionVC = nil
            
        case .Album:
            albumListVC = nil
            
        case .Media:
            mediaListVC = nil
            
        case .Preview:
            previewVC = nil
            
        case .All:
            permissionVC = nil
            albumListVC = nil
            mediaListVC = nil
            previewVC = nil
        }
    }
    
    
    func setupNavigationController(){
        navVC.setNavigationBarHidden(true, animated: false)
        TDMediaUtil.addChildController(navVC, toController: self)
    }
}
