//
//  TDMediaPickerController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

public protocol TDMediaPickerDelegate: class{
    func mediaPicker(_ picker: TDMediaPicker, didSelectMedia media:[TDMedia])
    func mediaPickerDidCancel(_ picker: TDMediaPicker)
}

open class TDMediaPicker: UIViewController, TDMediaPickerServiceManagerDelegate{
    
    // MARK: - Variable(s)
    
    enum ScreenType{
        case Permission, Album, Media, Preview, All
    }
    
    
    open weak var delegate:  TDMediaPickerDelegate?
    var maxSelections = 300
    
    var permissionVC: TDMediaPermissionViewController?
    var albumListVC: TDAlbumListViewController?
    var mediaListVC: TDMediaListViewController?
    var previewVC: TDMediaPreviewViewController?
    
    lazy var navVC          = UINavigationController()
    lazy var seviceManager  = TDMediaPickerServiceManager()
        
    // MARK: - Init
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        
        seviceManager.delegate = self
        seviceManager.setupConfig(maxSelections: maxSelections)
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
    
    override open func viewDidDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Setup Method(s)
    
    func setupScreen(_ screenType:TDMediaPicker.ScreenType){
        switch screenType {
        
        case .Permission:
            if permissionVC != nil{
                permissionVC = nil
            }
            permissionVC = TDMediaPermissionViewController()
            permissionVC?.delegate = self
            
        case .Album:
            if albumListVC != nil{
                albumListVC = nil
            }
            albumListVC = TDAlbumListViewController()
            albumListVC?.delegate = self
            
        case .Media:
            if mediaListVC != nil{
                mediaListVC = nil
            }
            mediaListVC = TDMediaListViewController()
            mediaListVC?.delegate = self
            
        case .Preview:
            if previewVC != nil{
                previewVC = nil
            }
            previewVC = TDMediaPreviewViewController()
            previewVC?.delegate = self
            
        default:
            print("No Use")
        }
    }
    
    func cleanupScreen(_ screenType:TDMediaPicker.ScreenType){
        switch screenType {
            
        case .Permission:
            if permissionVC != nil{
                permissionVC = nil
            }
            
        case .Album:
            if albumListVC != nil{
                albumListVC = nil
            }
            
        case .Media:
            if mediaListVC != nil{
                mediaListVC = nil
            }
            
        case .Preview:
            if previewVC != nil{
                previewVC = nil
            }
            
        case .All:
            if permissionVC != nil{
                permissionVC = nil
            }
            if albumListVC != nil{
                albumListVC = nil
            }
            if mediaListVC != nil{
                mediaListVC = nil
            }
            if previewVC != nil{
                previewVC = nil
            }
        }
    }
    
    
    func setupNavigationController(){
        navVC.setNavigationBarHidden(true, animated: false)
        TDMediaUtil.addChildController(navVC, toController: self)
    }
    
    // MARK: - Display Screen Method(s)
    
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
    
    func resetPicker(){
        seviceManager.resetSelectedMedia()
        navVC.popToRootViewController(animated: false)
    }
}

