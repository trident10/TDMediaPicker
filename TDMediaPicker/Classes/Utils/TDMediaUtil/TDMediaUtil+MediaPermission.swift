//
//  TDMediaUtil+MediaPermission.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 18/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation
import Photos

extension (TDMediaUtil){
    
    static func hasPermission(accessType : MediaPermissionType) -> Bool
    {
        switch accessType {
        case .Microphone:
            return isMicAvailable()
        case .Camera:
            return isCameraAvailable()
        case .Gallery:
            return isGalleryAvailable()
        }
    }
    
    static func requestForHardwareAccess(accessType : MediaPermissionType, completionBlock: @escaping (_ isGranted: Bool)-> Void)
    {
        switch accessType {
        case .Camera:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (isGranted) in
                completionBlock(isGranted)
            })
        case .Microphone:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (isGranted) in
                completionBlock(isGranted)
            })
        case .Gallery:
            PHPhotoLibrary.requestAuthorization({ (authorizationStatus) in
                if authorizationStatus == .authorized
                {
                    completionBlock(true)
                }
                else{
                    completionBlock(false)
                }
            })
        }
    }
    
    
    //MARK:- Checking User Access
    private static func isMicAvailable()-> Bool{
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio) ==  AVAuthorizationStatus.authorized
        {
            return true
        }
        else{
            return false
        }
    }
    
    private static func isCameraAvailable()-> Bool{
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized
        {
            return true
        }
        else{
            return false
        }
    }
    
    private static func isGalleryAvailable()-> Bool{
        let authorizationStatus :PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            return true
        case .notDetermined:
            return false
        default:
            return false
        }
        
    }
    
}
