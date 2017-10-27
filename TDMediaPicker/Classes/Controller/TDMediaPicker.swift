//
//  TDMediaPickerController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

public protocol TDMediaPickerDelegate: class{
    func mediaPicker(_ picker: TDMediaPicker, didSelectMedia media:[TDMedia])
    func mediaPickerDidCancel(_ picker: TDMediaPicker)
}

open class TDMediaPicker: UIViewController, TDMediaPickerServiceManagerDelegate{
    
    // MARK: - Variable(s)
    public enum AlbumCollectionType: Int {
        case Grid = 1, List = 2
    }
    
    enum ScreenType{
        case Permission, Album, Media, Preview, All
    }
    
    open weak var delegate:  TDMediaPickerDelegate?
    open weak var dataSource:  TDMediaPickerDataSource?
    
    var permissionVC: TDMediaPermissionViewController?
    var albumListVC: TDAlbumListViewController?
    var mediaListVC: TDMediaListViewController?
    var previewVC: TDMediaPreviewViewController?
    
    lazy var navVC          = UINavigationController()
    lazy var serviceManager  = TDMediaPickerServiceManager()
        
    // MARK: - Init
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        serviceManager.delegate = self
    }
    
    deinit {
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        
        if TDMediaUtil.hasPermission(accessType: .Gallery){
            showPickerScreen()
            return
        }
        showPermissionScreen()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        setupInitialConfiguration()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        cleanupScreen(.All)
        resetPicker()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func resetPicker(){
        serviceManager.resetSelectedMedia()
        navVC.popToRootViewController(animated: false)
    }
}

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

//MARK:- SCREEN DISPLAY METHOD(S)
extension TDMediaPicker{
    
    func showPickerScreen(){
        setupScreen(.Album)
        navVC.setViewControllers([albumListVC!], animated: false)
    }
    
    func showPermissionScreen(){
        setupScreen(.Permission)
        navVC.setViewControllers([permissionVC!], animated: false)
    }
    
    func showPreviewScreen(){
        
    }
    
}

