//
//  TDMediaPreviewServiceManager.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

protocol TDMediaPreviewServiceManagerDelegate: class {
    func mediaPreviewServiceManager(_ manager: TDMediaPreviewServiceManager, didUpdateCart cart: TDCart, updateType: TDCart.UpdateType, shouldDisplayAddMoreOption: Bool)
}

class TDMediaPreviewServiceManager: TDCartServiceManagerDelegate{
    
    // MARK: - Variable(s)
    
    lazy private var mediaItems:[TDMedia] = []
    private var cartServiceManager = TDCartServiceManager.sharedInstance
    
    weak var delegate:TDMediaPreviewServiceManagerDelegate?
    
    public init() {
        cartServiceManager.add(delegate: self)
    }
    
    // MARK: - Public Method(s)
    
    func fetchMediaItems(){
        self.cartServiceManager.refresh()
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
    
    // MARK: - CartService Manager Delegate Method(s)
    
    
    func cartServiceManager(_ manager: TDCartServiceManager, cartDidUpdate cart: TDCart, updateType: TDCart.UpdateType) {
        
        if updateType == .reload{
            if cartServiceManager.getConfig() > cart.media.count{
                self.delegate?.mediaPreviewServiceManager(self, didUpdateCart: cart, updateType: updateType, shouldDisplayAddMoreOption: true)
                return
            }
            self.delegate?.mediaPreviewServiceManager(self, didUpdateCart: cart, updateType: updateType, shouldDisplayAddMoreOption: false)
            return
        }
        
        print("this updateType of TDCart is not supported \(updateType)")
    }
    
}

