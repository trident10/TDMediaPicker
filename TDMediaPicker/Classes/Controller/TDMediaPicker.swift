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
    //Max Selection
    @objc optional func mediaPickerMaxSelections(_ picker: TDMediaPicker)-> Int
    
    //Filter Specific Media Type
    @objc optional func mediaPickerFilterMediaTpye(_ picker: TDMediaPicker)-> PHAssetMediaType
    
    //THEME
    @objc optional func mediaPickerNavigationTheme(_ picker: TDMediaPicker)-> TDConfigViewStandard
    @objc optional func mediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView
    
    //Permission Screen
    @objc optional func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker)-> TDConfigPermissionScreen
    
    //Album List Screen
    @objc optional func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    @objc optional func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]
    @objc optional func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPicker.AlbumCollectionType
    @objc optional func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize
    @objc optional func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText
    @objc optional func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?
    
    //Media List Screen
    @objc optional func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    @objc optional func mediaPickerMediaListNumberOfColumnInPortrait(_ picker: TDMediaPicker)-> Int
    @objc optional func mediaPickerMediaListNumberOfColumnInLandscape(_ picker: TDMediaPicker)-> Int
    @objc optional func mediaPicker(_ picker: TDMediaPicker, countForMedia mediaCount: Int)-> TDConfigView
    
    //Preview Screen
    @objc optional func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    @objc optional func mediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker)-> TDConfigView
    @objc optional func mediaPickerPreviewThumbnailAddView(_ picker: TDMediaPicker)-> TDConfigView
    @objc optional func mediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker)-> Bool
    @objc optional func mediaPickerPreviewCaptionTextLimit(_ picker: TDMediaPicker)-> Int
    @objc optional func mediaPickerPreviewCaptionView(_ picker: TDMediaPicker)->TDConfigCaptionView
    
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
        
        if let maxSel = self.dataSource?.mediaPickerMaxSelections?(self){
            maxSelections = maxSel
            serviceManager.setupConfig(maxSelections: maxSelections)
        }
        
        if TDMediaUtil.hasPermission(accessType: .Gallery){
            showPickerScreen()
            return
        }
        showPermissionScreen()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        setupInitialConfiguration()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        cleanupScreen(.All)
        resetPicker()
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
            albumListVC?.dataSource = self
            
        case .Media:
            if mediaListVC != nil{
                mediaListVC = nil
            }
            mediaListVC = TDMediaListViewController()
            mediaListVC?.delegate = self
            mediaListVC?.dataSource = self
            
        case .Preview:
            if previewVC != nil{
                previewVC = nil
            }
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

