//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation
import TDMediaPicker
import Photos

class Theme1: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: .lightGray)
        var permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0xD24D57), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "close"), customSize: CGSize.init(width: 20, height: 20))
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0xF62459), textFont: UIFont.boldSystemFont(ofSize: 20)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: .lightGray)
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 90, height: 90)
    }
    
    override func getNumberOfColumnInPortrait()->Int{
        return 5
    }
    
    override func getNumberOfColumnInLandscape()->Int{
        return 10
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        var configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        var nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Camera Roll"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n\n%d",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.systemFont(ofSize: 16))
    }
    
    override func getMediaHighlightedCellView(mediaCount: Int)->TDViewConfig{
        return TDConfigViewStandard(backgroundColor: .red)
    }
    
    override func getIsHideCaptionView() -> Bool {
        return false
    }
    
    override func getMaxNumberOfSelection() -> Int {
        return 1
    }
    
    override func getVideoThumbOverlay() -> TDViewConfig {
        let myView: VideoThumbCellView = .fromNib()
        myView.imageView.image = #imageLiteral(resourceName: "video_thumb")
        myView.bottomView.backgroundColor = .init(white: 1, alpha: 0.8)
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getSelectedThumbnailView() -> TDViewConfig {
        let myView: HightLightedCellView = .fromNib()
        myView.countLabel.isHidden = true
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getPreviewThumbnailAddView() -> TDViewConfig {
        let myView: HightLightedCellView = .fromNib()
        myView.backgroundColor = .clear
        myView.countLabel.isHidden = true
        myView.imageView.image = #imageLiteral(resourceName: "add")
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getFetchResultsForAlbumScreen() -> [PHFetchResult<PHAssetCollection>] {
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        return types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
    }
    
}


