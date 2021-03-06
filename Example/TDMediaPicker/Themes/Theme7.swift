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

class Theme7: ThemeConfig{
    
    override func getPermissionScreenConfig() -> TDConfigPermissionScreen {
        let permissionConfig = TDConfigPermissionScreen()
        permissionConfig.settingButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "scan_qr_button"), customSize: CGSize.init(width: 32, height: 32))
        permissionConfig.cancelButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "close"), customSize: CGSize.init(width: 16, height: 16))
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "Open the Settings to enable photos access for your app.", textColor: UIColor(rgb: 0xc0392b), textFont: UIFont.boldSystemFont(ofSize: 18)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
        
        return permissionConfig
    }
    
    override func getNavigationThemeConfig() -> TDConfigViewStandard {
        return TDConfigViewStandard.init(backgroundColor: .clear)
    }
    
    override func getImageSizeForAlbum()->CGSize{
        return CGSize(width: 65, height: 65)
    }
    
    override func getAlbumNavBarConfig()->TDConfigNavigationBar{
        return TDConfigNavigationBar()
    }
    
    override func getSelectedAlbumAtInitialLoad(albums: [TDAlbum])->TDAlbum?{
        return nil
    }
    
    override func getTextFormatForAlbum(album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n%d",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.boldSystemFont(ofSize: 15))
    }
    
    override func getMediaHighlightedCellView(mediaCount: Int)->TDConfigView{
        return TDConfigViewStandard(backgroundColor: .red)
    }
    
    
    override func getNumberOfColumnInPortrait()->Int{
        return 4
    }
    
    override func getNumberOfColumnInLandscape()->Int{
        return 7
    }
    
    override func getIsHideCaptionView() -> Bool {
        return false 
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
        myView.imageView.image = #imageLiteral(resourceName: "selected")
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


