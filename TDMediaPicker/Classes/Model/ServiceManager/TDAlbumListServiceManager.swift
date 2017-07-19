//
//  TDAlbumListServiceManager.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

protocol TDAlbumListServiceManagerDelegate:class {
    func albumServiceManager(_ manager: TDAlbumListServiceManager, didFetchAlbums albums: [TDAlbum])

}

class TDAlbumListServiceManager {
    
    // MARK: - Variable(s)
    private var albumsFetchResults = [PHFetchResult<PHAssetCollection>]()
    
    lazy private var albums:[TDAlbum] = []

    weak var delegate: TDAlbumListServiceManagerDelegate?
    
    // MARK: - Public Method(s)
    
    func purgeData(){
        albums.removeAll()
    }
    
    func fetchAlbums(){
        DispatchQueue.global().async {
            self.fetchAlbumsFromLibrary()
            DispatchQueue.main.async {
                self.delegate?.albumServiceManager(self, didFetchAlbums: self.albums)
            }
        }
    }
    
    // MARK: - Private Method(s)
    
    fileprivate func fetchAlbumsFromLibrary() {
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        
        albumsFetchResults = types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
        
        albums.removeAll()
        
        for result in albumsFetchResults {
            result.enumerateObjects({ (collection, _, _) in
                let album = TDAlbum(collection: collection)
                album.reload()
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
}
