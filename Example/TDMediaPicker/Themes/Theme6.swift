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

class Theme6: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let configView = TDConfigViewStandard(backgroundColor: UIColor(rgb: 0x6C7A89))
        let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x19B5FE), normalTextConfig: TDConfigText.init(text: "Open Settings", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 15)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonText.init(normalColor: UIColor(rgb: 0x19B5FE), normalTextConfig: TDConfigText.init(text: "Close", textColor: .white, textFont: UIFont.init(name: "Palatino-Bold", size: 15)), cornerRadius: 6.0)
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Allow TDMedia Picker to access your photos.", textColor: UIColor(rgb: 0x19B5FE), textFont: UIFont.init(name: "Palatino-Bold", size: 22)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: UIColor(rgb: 0x6C7A89))
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 80, height: 120)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        return TDConfigNavigationBar()
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        for album in albums{
            if album.collection.localizedTitle == "Screenshots"{
                return album
            }
        }
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        let str = String(format: "%@\n\nFiles: %d",album.collection.localizedTitle!,mediaCount)
        return TDConfigText.init(text: str, textColor: .black, textFont: UIFont.init(name: "Palatino-Bold", size: 17))
    }
    
    override func getMediaHighlightedCellView(mediaCount: Int)->TDConfigView{
        let myView: HightLightedCellView = UIView.fromNib()
        myView.countLabel.text = String(mediaCount)
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getNumberOfColumnInPortrait()->Int{
        return 5
    }
    
    override func getNumberOfColumnInLandscape()->Int{
        return 10
    }
    
    
    override func getIsHideCaptionView() -> Bool {
        return true
    }
    
    override func getMaxNumberOfSelection() -> Int {
        return 30
    }
    
    override func getVideoThumbOverlay() -> TDConfigView {
        let myView: VideoThumbCellView = .fromNib()
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getSelectedThumbnailView() -> TDConfigView {
        let myView: HightLightedCellView = .fromNib()
        myView.countLabel.isHidden = true
        return TDConfigViewCustom.init(view: myView)
    }
    
    override func getPreviewThumbnailAddView() -> TDConfigView {
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


