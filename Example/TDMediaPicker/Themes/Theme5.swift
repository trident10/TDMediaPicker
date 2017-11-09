//
//  Theme1.swift
//  TDMediaPicker
//
//  Created by Abhimanu Jindal on 04/09/17.
//  Copyright © 2017 abhimanyujindal10. All rights reserved.
//


import Foundation
import TDMediaPicker
import Photos

class Theme5: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        
        // View
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0xF5D76E))
        
        // Settings Button
        var buttonSettingsConfig = TDConfigButtonText()
        //Color
        buttonSettingsConfig.normalColor = .clear
        buttonSettingsConfig.highlightedColor = .clear
        //Text
        var butonSettingsTextConfig = TDConfigText(text: "")
        butonSettingsTextConfig.text = "Open Settings"
        butonSettingsTextConfig.textColor = UIColor(rgb: 0xF62459)
        butonSettingsTextConfig.textFont = UIFont.init(name: "BradleyHandITCTT-Bold", size: 25)
        buttonSettingsConfig.normalTextConfig = butonSettingsTextConfig
            
            
        // Cancel Button
        var buttonCancelConfig = TDConfigButtonText()
        //Color
        buttonCancelConfig.normalColor = .clear
        buttonCancelConfig.highlightedColor = .clear
        //Text
        var buttonCancelTextConfig = TDConfigText(text: "")
        buttonCancelTextConfig.text = "Cancel"
        buttonCancelTextConfig.textColor = UIColor(rgb: 0xF62459)
        buttonCancelTextConfig.textFont = UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)
        buttonCancelConfig.normalTextConfig = buttonCancelTextConfig
        
        //Caption Text
        let labelCaptionView = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 24)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        
        var permissionConfig = TDConfigPermissionScreen()
        permissionConfig.standardView = configView
        permissionConfig.settingButton = buttonSettingsConfig
        permissionConfig.cancelButton = buttonCancelConfig
        permissionConfig.caption = labelCaptionView
        

        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0xF5D76E))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 78, height: 78)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        var configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)), cornerRadius: 6.0)
        var nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .lightGray, textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20)))
        //configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0xF5D76E))
        return configNavBar
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Videos"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n%d",album.collection.localizedTitle!,mediaCount), textColor: UIColor(rgb: 0x003171), textFont: UIFont.init(name: "BradleyHandITCTT-Bold", size: 20))
    }
    
    override func getMediaHighlightedCellView(mediaCount: Int)->TDConfigView{
        let myView: HightLightedCellView = .fromNib()
        myView.imageView.image = #imageLiteral(resourceName: "check-5")
        myView.countLabel.textColor = UIColor(rgb: 0x003171)
        myView.countLabel.text = String(mediaCount)
        return TDConfigViewCustom.init(view: myView)
    }
    
    
    override func getNumberOfColumnInPortrait()->Int{
        return 3
    }
    
    override func getNumberOfColumnInLandscape()->Int{
        return 7
    }
    
    override func getIsHideCaptionView() -> Bool {
        return false
    }
    
    override func getMaxNumberOfSelection() -> Int {
        return 12
    }
    
    override func getVideoThumbOverlay() -> TDConfigView {
        let myView: VideoThumbCellView = .fromNib()
        myView.imageView.image = #imageLiteral(resourceName: "video_thumb")
        myView.bottomView.backgroundColor = .init(white: 1, alpha: 0.8)
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getSelectedThumbnailView() -> TDConfigView {
        let myView: HightLightedCellView = .fromNib()
        myView.imageView.image = #imageLiteral(resourceName: "selected-5")
        myView.countLabel.isHidden = true
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getPreviewThumbnailAddView() -> TDConfigView {
        let myView: HightLightedCellView = .fromNib()
        myView.backgroundColor = .clear
        myView.countLabel.isHidden = true
        myView.imageView.image = #imageLiteral(resourceName: "add-1")
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getFetchResultsForAlbumScreen() -> [PHFetchResult<PHAssetCollection>] {
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        return types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
    }
    
}


