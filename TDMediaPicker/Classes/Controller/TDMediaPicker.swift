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

@objc public protocol TDMediaPickerDataSource{
    
    //THEME
    @objc optional func mediaPickerNavigationTheme(_ picker: TDMediaPicker)-> TDConfigViewStandard
    
    //Permission Screen
    @objc optional func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker)-> TDConfigPermissionScreen
    
    //Album List Screen
    @objc optional func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    @objc optional func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]
    @objc optional func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPicker.AlbumCollectionType
    @objc optional func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize
    @objc optional func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int, selectedCount: Int)-> TDConfigText
    @objc optional func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?
    
    //Media List Screen
    @objc optional func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    
    //Preview Screen
    @objc optional func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    
}

open class TDMediaPicker: UIViewController, TDMediaPickerServiceManagerDelegate{
    
    // MARK: - Variable(s)
    
    @objc public enum AlbumCollectionType: Int {
        case Grid = 1, List = 2
    }
    
    enum ScreenType{
        case Permission, Album, Media, Preview, All
    }
    
    open weak var delegate:  TDMediaPickerDelegate?
    open weak var dataSource:  TDMediaPickerDataSource?
    
    var maxSelections = 300
    
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
        serviceManager.setupConfig(maxSelections: maxSelections)
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
    
    override open func viewDidDisappear(_ animated: Bool) {
        
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
            albumListVC?.datasource = self
            
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

