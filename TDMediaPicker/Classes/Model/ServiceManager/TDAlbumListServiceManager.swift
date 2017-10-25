//
//  TDAlbumListServiceManager.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

protocol TDAlbumListServiceManagerDelegate: class {

}

class TDAlbumListServiceManager {
    
    // MARK: - Variable(s)
    private var albumsFetchResults = [PHFetchResult<PHAssetCollection>]()
    
    private var configServiceManager = TDConfigServiceManager.sharedInstance
    private var cartServiceManager = TDCartServiceManager.sharedInstance

    lazy private var albums: [TDAlbum] = []

    weak var delegate: TDAlbumListServiceManagerDelegate?
    
    // MARK: - Public Method(s)
    
    func purgeData(){
        albums.removeAll()
    }
    
    func fetchAlbums(_ fetchResults: [PHFetchResult<PHAssetCollection>]?, completion: @escaping ([TDAlbum]) -> Void){
        DispatchQueue.global().async {
            self.fetchAlbumsFromLibrary(fetchResults)
            DispatchQueue.main.async {
                completion(self.albums)
            }
        }
    }
    
    func fetchAlbum(_ albumId: String)-> [TDAlbum]{
        return self.albums.filter { (album) -> Bool in
            return album.id == albumId
        }
    }
    
    func fetchSelectedMediaForAlbum(_ album: [TDMedia])-> [TDMedia]?{
        return cartServiceManager.getSelectedMedia(album)
    }
    
    func getNavigationThemeConfig()-> TDConfigViewStandard{
        return configServiceManager.navigationTheme
    }
    
    func getAlbumScreenConfig()-> TDConfigAlbumScreen{
        return configServiceManager.albumScreenConfig
    }
    
    // MARK: - Private Method(s)
    
    fileprivate func fetchAlbumsFromLibrary(_ fetchResults: [PHFetchResult<PHAssetCollection>]?) {
        
        if fetchResults != nil{
            albumsFetchResults = fetchResults!
        }
        else{
            let types: [PHAssetCollectionType] = [.smartAlbum, .album]
            
            albumsFetchResults = types.map {
                return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
            }
        }
        
        albums.removeAll()
        
        for result in albumsFetchResults {
            result.enumerateObjects({ (collection, _, _) in
                var album = TDAlbum(collection: collection)
                album.reload(filteredMediaType: self.configServiceManager.albumScreenConfig.mediaType)
                if album.itemsCount > 0 {
                    self.albums.append(album)
                }
            })
        }
        
        // Move Camera Roll first
        if let index = albums.index(where: { $0.collection.assetCollectionSubtype == . smartAlbumUserLibrary }) {
            
            guard index != 0 && index < albums.count else { return }
            let item = albums[index]
            albums.remove(at: index)
            albums.insert(item, at: 0)
        }
    }
    
    
    func fetchAlbum(_ id: String, completion: (TDAlbum?) -> Void){
        let matchedAlbum = albums.filter { (album) -> Bool in
            return album.id == id
        }
        if matchedAlbum.count > 0{
            completion(matchedAlbum[0])
            return
        }
        completion(nil)
    }
}
