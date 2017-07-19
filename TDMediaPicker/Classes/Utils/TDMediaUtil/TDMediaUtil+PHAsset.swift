//
//  TDMediaUtil+UIImageView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

extension (TDMediaUtil){
 
    static func fetchImage(_ asset:PHAsset, targetSize: CGSize , completionHandler: @escaping (UIImage?, Error?) -> Void){
        let handler = completionHandler
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        _ = PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options, resultHandler: { (image, options) in
            handler(image,nil)
        })
    }
    
    static func fetchDuration(_ asset: PHAsset, completionHandler: @escaping (Double) -> Void) {
        let handler = completionHandler
        
        if asset.mediaType != .video && asset.mediaType != .audio {
            handler(0)
        }
        
        _ = PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) {
            asset, mix, _ in
            let duration = asset?.duration.seconds ?? 0
            handler(duration)
        }
    }
    
    static func fetchPlayerItem(_ asset: PHAsset, completionHandler: @escaping (AVPlayerItem?) -> Void) {
        let options = PHVideoRequestOptions()
        options.deliveryMode = .automatic
        PHImageManager.default().requestPlayerItem(forVideo: asset, options: options) {
            item, _ in
            DispatchQueue.main.async {
                completionHandler(item)
            }
        }
    }
    
    static func fetchAVAsset(_ asset: PHAsset, completionHandler: @escaping (AVAsset?) -> Void){
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { avAsset, _, _ in
            DispatchQueue.main.async {
                completionHandler(avAsset)
            }
        }
    }
    
}
