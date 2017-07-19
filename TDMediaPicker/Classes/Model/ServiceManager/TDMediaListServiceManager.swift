//
//  TDMediaListServiceManager.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

protocol TDMediaListServiceManagerDelegate:class {
    func mediaListServiceManager(_ manager: TDMediaListServiceManager, didFetchMedia media: [TDMedia])
    func mediaListServiceManager(_ manager: TDMediaListServiceManager, didUpdateCart media: [TDMedia], updateType: TDCart.UpdateType)
}

class TDMediaListServiceManager: TDCartServiceManagerDelegate {
    
    // MARK: - Variable(s)
    
    lazy private var mediaItems:[TDMedia] = []
    
    private var cartServiceManager = TDCartServiceManager.sharedInstance
    
    weak var delegate:TDMediaListServiceManagerDelegate?
    
    public init() {
        cartServiceManager.add(delegate: self)
    }
    
    // MARK: - Public Method(s)
    
    func fetchMediaItems(album: TDAlbum){
        DispatchQueue.global().async {
            self.fetchMediaItemsFromLibrary(album: album)
            DispatchQueue.main.async {
                self.delegate?.mediaListServiceManager(self, didFetchMedia: self.mediaItems)
                self.cartServiceManager.refresh()
            }
        }
    }
    
    func purgeData(){
        mediaItems.removeAll()
    }
    
    // MARK: ... Cart Method(s)
    
    func addMediaToCart(_ media: TDMedia){
        cartServiceManager.add(media)
    }
    
    func removeMediaFromCart(_ media: TDMedia){
        cartServiceManager.remove(media)
    }
    
    // MARK: - Private Method (s)
    
    private func fetchMediaItemsFromLibrary(album: TDAlbum){
        
        self.mediaItems.removeAll()
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let itemsFetchResult = PHAsset.fetchAssets(in: album.collection, options: options)
        itemsFetchResult.enumerateObjects({ (asset, count, stop) in
            self.mediaItems.append(TDMedia(asset: asset))
        })
    }
    
    // MARK: - CartService Manager Delegate Method(s)
    
    func cartServiceManager(_ cart: TDCartServiceManager, cartDidUpdate totalMedia: [TDMedia], updateType: TDCart.UpdateType) {
        self.delegate?.mediaListServiceManager(self, didUpdateCart: totalMedia, updateType: updateType)
    }
    
}

