//
//  ViewController+MediaPickerDataSource.swift
//  TDMediaPicker
//
//  Created by Abhimanu Jindal on 04/09/17.
//  Copyright © 2017 abhimanyujindal10. All rights reserved.
//


import UIKit
import TDMediaPicker
import Photos

extension ViewController: TDMediaPickerDataSource{

    
    //MARK:- Max Selection
    func mediaPickerMaxSelections(_ picker: TDMediaPicker)-> Int{
        let themeConfig = getThemeConfig()
        return themeConfig.getMaxNumberOfSelection()
    }
    
    //MARK:- Filter Specific Media
//    func mediaPickerFilterMediaTpye(_ picker: TDMediaPicker)-> PHAssetMediaType?{
//        return PHAssetMediaType.video
//    }
    
    //MARK:- Navigation Bar Theme
    
//    func mediaPickerNavigationTheme(_ picker: TDMediaPicker) -> TDConfigViewStandard {
//        let themeConfig = getThemeConfig()
//        return themeConfig.getNavigationThemeConfig()
//    }
    
    func mediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView{
        let themeConfig = getThemeConfig()
        return themeConfig.getVideoThumbOverlay()
    }
    
    //MARK:-  Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker) -> TDConfigPermissionScreen {
        let themeConfig = getThemeConfig()
        return themeConfig.getPermissionScreenConfig()
    }
    
    //MARK:- Album Screen
    func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let themeConfig = getThemeConfig()
        return themeConfig.getAlbumNavBarConfig()
    }
    
    func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]{
        let themeConfig = getThemeConfig()
        return themeConfig.getFetchResultsForAlbumScreen()
    }
    
    func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPicker.AlbumCollectionType{
        return .List
    }
    
    func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize{
        let themeConfig = getThemeConfig()
        return themeConfig.getImageSizeForAlbum()
    }
    
    func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText{
        let themeConfig = getThemeConfig()
        return themeConfig.getTextFormatForAlbum(album: album, mediaCount: mediaCount)
    }     
    
    func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?{
        let themeConfig = getThemeConfig()
        return themeConfig.getSelectedAlbumAtInitialLoad(albums: albums)
    }
    
    //MARK:- Media Screen
    func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let themeConfig = getThemeConfig()
        return themeConfig.getAlbumNavBarConfig()
    }
    
    func mediaPickerMediaListNumberOfColumnInPortrait(_ picker: TDMediaPicker)-> Int{
        let themeConfig = getThemeConfig()
        return themeConfig.getNumberOfColumnInPortrait()
    }
    
    func mediaPickerMediaListNumberOfColumnInLandscape(_ picker: TDMediaPicker)-> Int{
        let themeConfig = getThemeConfig()
        return themeConfig.getNumberOfColumnInLandscape()
    }
    
    func mediaPicker(_ picker: TDMediaPicker, countForMedia mediaCount: Int) -> TDConfigView {
        let themeConfig = getThemeConfig()
        return themeConfig.getMediaHighlightedCellView(mediaCount: mediaCount)
    }
    
    //MARK:- Preview Screen
    func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        let themeConfig = getThemeConfig()
        return themeConfig.getAlbumNavBarConfig()
    }
    func mediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker) -> TDConfigView {
        let themeConfig = getThemeConfig()
        return themeConfig.getSelectedThumbnailView()
    }
    
    func mediaPickerPreviewThumbnailAddView(_ picker: TDMediaPicker) -> TDConfigView {
        let themeConfig = getThemeConfig()
        return themeConfig.getPreviewThumbnailAddView()
    }
    
    func mediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker) -> Bool {
        let themeConfig = getThemeConfig()
        return themeConfig.getIsHideCaptionView()
    }
    
}

extension ViewController{
    func getThemeConfig()->ThemeConfig{
        switch selectedTheme {
        case .theme1:
            return Theme1()
        case .theme2:
            return Theme2()
        case .theme3:
            return Theme3()
        case .theme4:
            return Theme4()
        case .theme5:
            return Theme5()
        case .theme6:
            return Theme6()
        case .theme7:
            return Theme7()
        }
    }
}
