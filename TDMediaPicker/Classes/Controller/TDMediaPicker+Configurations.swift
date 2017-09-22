//
//  TDMediaPicker+Configurations.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

//MARK:- CONFIGURATION METHOD(S)
extension TDMediaPicker{
    
    //MARK: - Public Method(s)
    
    func setupInitialConfiguration(){
        
        if let viewConfig = dataSource?.mediaPickerNavigationTheme?(self){
            serviceManager.setupConfig(navigationTheme: viewConfig)
        }
        
        //1. Initial Configurations
        setupAlbumScreenConfiguration()
        setupMediaScreenConfiguration()
        setupPreviewScreenConfiguration()
    }
    
    func getMediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView?{
        return dataSource?.mediaPickerVideoThumbOverlay?(self)
    }
    //MARK: ...Album Config Method(s)
    func getSelectedAlbumAtInitialLoad(albums: [TDAlbum]) -> TDAlbum? {
        return self.dataSource?.mediaPicker?(self, selectedAlbumAtInitialLoad: albums)
    }
    
    func getAlbumText(album: TDAlbum, mediaCount: Int) -> TDConfigText? {
        return self.dataSource?.mediaPicker?(self, textFormatForAlbum: album, mediaCount: mediaCount)
    }
    
    //MARK: ...Media Config Method(s)
    func getMediaHighlightedView(_ picker: TDMediaPicker, countForMedia mediaCount: Int)-> TDConfigView?{
        return self.dataSource?.mediaPicker?(self, countForMedia: mediaCount)
    }
    
    //MARK: ...Preview Config Method(s)
    func getMediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker)-> TDConfigView?{
        return self.dataSource?.mediaPickerPreviewSelectedThumbnailView?(self)
    }
    
    func getMediaPickerPreviewAddThumbnailView(_ picker: TDMediaPicker)-> TDConfigView?{
        return self.dataSource?.mediaPickerPreviewThumbnailAddView?(self)
    }
    func getMediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker) -> Bool? {
        return self.dataSource?.mediaPickerPreviewHideCaptionView?(self)
    }
    
    //MARK: - Private Method(s)
    //MARK: ...Album Config Method(s)

    private func setupAlbumScreenConfiguration(){
        let albumConfig = TDConfigAlbumScreen()
        if let navBarConfig = dataSource?.mediaPickerAlbumNavBarConfig?(self){
            albumConfig.navigationBar = navBarConfig
        }
        if let fetchResult = dataSource?.mediaPickerFetchResultsForAlbumScreen?(self){
            albumConfig.fetchResults = fetchResult
        }
        if let albumCollectionType = dataSource?.mediaPickerCollectionTypeForAlbumScreen?(self){
            albumConfig.collectionType = albumCollectionType
        }
        if let size = dataSource?.mediaPickerImageSizeForAlbum?(self){
            albumConfig.imageSize = size
        }
        if let mediaType = dataSource?.mediaPickerFilterMediaTpye?(self){
            albumConfig.mediaType = mediaType
        }
        serviceManager.setupConfig(albumScreen: albumConfig)
    }
    
    //MARK: ...Media Config Method(s)
    
    private func setupMediaScreenConfiguration(){
        let mediaConfig = TDConfigMediaScreen()
        if let navBarConfig = dataSource?.mediaPickerMediaNavBarConfig?(self){
            mediaConfig.navigationBar = navBarConfig
        }
        if let coulmn = dataSource?.mediaPickerMediaListNumberOfColumnInPortrait?(self){
            mediaConfig.portraitColumns = coulmn
        }
        if let coulmn = dataSource?.mediaPickerMediaListNumberOfColumnInLandscape?(self){
            mediaConfig.landscapeColumns = coulmn
        }
        serviceManager.setupConfig(mediaScreen: mediaConfig)
    }
    
    //MARK: ...Preview Config Method(s)
    
    private func setupPreviewScreenConfiguration(){
        let previewConfig = TDConfigPreviewScreen()
        if let navBarConfig = dataSource?.mediaPickerPreviewNavBarConfig?(self){
            previewConfig.navigationBar = navBarConfig
        }
        if let videoThumbOverLay = dataSource?.mediaPickerVideoThumbOverlay?(self){
            previewConfig.videoThumbOverlay = videoThumbOverLay
        }
        serviceManager.setupConfig(previewScreen: previewConfig)
    }
    
    
}
