//
//  TDMediaPickerController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

/*
 To Do -
 Separate Files
 1. TDMediaPickerDatasource
 2. TDMediaPickerDelegate
 3. TDMediaPickerConfiguration - Singleton holding default values
 
 Freeze default configuration theme
 */

public protocol TDMediaPickerDelegate: class{
    func mediaPicker(_ picker: TDMediaPicker, didSelectMedia media:[TDMedia])
    func mediaPickerDidCancel(_ picker: TDMediaPicker)
}

public protocol TDMediaPickerDataSource: class{
    //Max Selection
    func mediaPickerMaxSelections(_ picker: TDMediaPicker)-> Int
    
    //Filter Specific Media Type
    func mediaPickerFilterMediaTpye(_ picker: TDMediaPicker)-> PHAssetMediaType
    
    //THEME
    func mediaPickerNavigationTheme(_ picker: TDMediaPicker)-> TDConfigViewStandard
    func mediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView
    
    //Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker)-> TDConfigPermissionScreen
    
    //Album List Screen
    func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]
    func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPicker.AlbumCollectionType
    func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize
    func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText
    func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?
    
    //Media List Screen
    func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerMediaListNumberOfColumnInPortrait(_ picker: TDMediaPicker)-> Int
    func mediaPickerMediaListNumberOfColumnInLandscape(_ picker: TDMediaPicker)-> Int
    func mediaPicker(_ picker: TDMediaPicker, countForMedia mediaCount: Int)-> TDConfigView
    
    //Preview Screen
    func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker)-> TDConfigView
    func mediaPickerPreviewThumbnailAddView(_ picker: TDMediaPicker)-> TDConfigView
    func mediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker)-> Bool
    
}

public extension TDMediaPickerDataSource{
    //Max Selection
    func mediaPickerMaxSelections(_ picker: TDMediaPicker)-> Int{
        return 30
    }
    
    //Filter Specific Media Type
    //FIXME:- NEED TO CHECK ITS IMPLEMENTATION
    func mediaPickerFilterMediaTpye(_ picker: TDMediaPicker)-> PHAssetMediaType{
        return .image
    }
    
    //THEME
    func mediaPickerNavigationTheme(_ picker: TDMediaPicker)-> TDConfigViewStandard{
        return TDConfigViewStandard.init(backgroundColor: .white)
    }
    //FIXME:- NEED TO ADD ITS XIB in Library
    func mediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView{
        return TDConfigView()
    }
    
    //Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker)-> TDConfigPermissionScreen{
        return TDConfigPermissionScreen.init(standardView: TDConfigViewStandard.init(backgroundColor: .white), caption: TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Please allow to access your photos", textColor: .black, textFont: UIFont.systemFont(ofSize: 12, weight: 12)), textAlignment: .center), settingButton: TDConfigButtonText.init( normalTextConfig: TDConfigText.init(text: "Settings", textColor: .blue, textFont: UIFont.systemFont(ofSize: 12, weight: 12))), cancelButton: TDConfigButtonText.init( normalTextConfig: TDConfigText.init(text: "Cancel", textColor: .blue, textFont: UIFont.systemFont(ofSize: 12, weight: 12))))
    }
    
    //Album List Screen
    func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        let nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]{
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        return types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
    }
    
    func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPicker.AlbumCollectionType{
        return .List
    }
    
    func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize{
        return CGSize(width: 90, height: 90)
    }
    
    func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n\n%d",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.systemFont(ofSize: 16))
    }
    
    func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?{
        
        for album in albums{
            if album.collection.localizedTitle == "Camera Roll"{
                return album
            }
        }
        return nil
    }
    
    //Media List Screen
    func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        let nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    func mediaPickerMediaListNumberOfColumnInPortrait(_ picker: TDMediaPicker)-> Int{
        return 5
    }
    
    func mediaPickerMediaListNumberOfColumnInLandscape(_ picker: TDMediaPicker)-> Int{
        return 10
    }
    
    func mediaPicker(_ picker: TDMediaPicker, countForMedia mediaCount: Int)-> TDConfigView{
        return TDConfigView()
    }
    
    //Preview Screen
    func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        let nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    func mediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker)-> TDConfigView{
        return TDConfigView()
    }
    
    func mediaPickerPreviewThumbnailAddView(_ picker: TDMediaPicker)-> TDConfigView{
        return TDConfigView()
    }
    
    func mediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker)-> Bool{
        return false
    }
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

