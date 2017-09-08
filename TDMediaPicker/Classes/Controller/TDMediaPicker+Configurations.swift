//
//  TDMediaPicker+Configurations.swift
//  Pods
//
//  Created by Yapapp on 08/09/17.
//
//

import Foundation

//MARK:- CONFIGURATION METHOD(S)
extension TDMediaPicker{
    
    //MARK: - Public Method(s)
    
    func setupInitialConfiguration(){
        
        if let viewConfig = dataSource?.mediaPickerNavigationTheme?(self){
            serviceManager.setupConfig(navigationTheme: viewConfig)
        }
        
        //1. Initial Album Configurations
        setupAlbumScreenConfiguration()
    }
    
    //MARK: ...Album Config Method(s)
    func getSelectedAlbumAtInitialLoad(albums: [TDAlbum]) -> TDAlbum? {
        return self.dataSource?.mediaPicker?(self, selectedAlbumAtInitialLoad: albums)
    }
    
    //MARK: - Private Method(s)
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
        serviceManager.setupConfig(albumScreen: albumConfig)
    }
}
