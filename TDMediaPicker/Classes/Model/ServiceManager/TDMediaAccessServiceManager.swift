//
//  TDMediaAccessServiceManager.swift
//  Pods-TDMediaPicker_Example
//
//  Created by Abhimanyu on 06/11/17.
//

import Foundation
import Photos

struct TDMediaAccessServiceManager{
    
    enum MediaPermissionType{
        case Microphone,Camera,Gallery
    }
    
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
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (isGranted) in
                completionBlock(isGranted)
            })
        case .Microphone:
            AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { (isGranted) in
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
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) ==  AVAuthorizationStatus.authorized
        {
            return true
        }
        else{
            return false
        }
    }
    
    private static func isCameraAvailable()-> Bool{
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized
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
