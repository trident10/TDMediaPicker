//
//  TDMediaPermissionViewController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPermissionViewControllerDelegate:class{
    func permissionControllerDidFinish(_ controller: TDMediaPermissionViewController)
    func permissionControllerDidTapClose(_ controller: TDMediaPermissionViewController)
    func permissionControllerDidRequestForConfig(_ controller: TDMediaPermissionViewController)-> TDPermissionScreenConfig?

}

class TDMediaPermissionViewController: UIViewController, TDMediaPermissionViewDelegate{
    
    // MARK: - Variables
    
    weak var delegate: TDMediaPermissionViewControllerDelegate?
    private lazy var serviceManager = TDPermissionServiceManager()
    private var permissionView: TDMediaPermissionView?
    
    
    // MARK: - Init
    
    public required init() {
        super.init(nibName: "TDMediaPermission", bundle: TDMediaUtil.xibBundle())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        permissionView = self.view as? TDMediaPermissionView
        permissionView?.delegate = self
        setupPermissionConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestGalleryPermission()
    }
    
    //MARK: - Private Method(s)
    
    private func setupPermissionConfig(){
        let config = self.delegate?.permissionControllerDidRequestForConfig(self)
        
        //1.
        if let customView = config?.customView{
            permissionView?.setupCustomView(view: customView)
            return
        }
        
        //2.
        var shouldDisplayDefaultScreen = true
        
        if let standardView = config?.standardView{
            permissionView?.setupStandardView(view: standardView)
            shouldDisplayDefaultScreen = false
        }
        if let settingsButtonConfig = config?.settingButton{
            permissionView?.setupSettingsButton(buttonConfig: settingsButtonConfig)
            shouldDisplayDefaultScreen = false
        }
        if let cancelButtonConfig = config?.cancelButton{
            permissionView?.setupCancelButton(buttonConfig: cancelButtonConfig)
            shouldDisplayDefaultScreen = false
        }
        if let captionConfig = config?.caption{
            permissionView?.setupCaptionLabel(captionConfig)
            shouldDisplayDefaultScreen = false
        }
        
        //3.
        if shouldDisplayDefaultScreen{
            permissionView?.setupDefaultScreen()
        }
        
    }
    
    private func requestGalleryPermission(){
        TDMediaAccessServiceManager.requestForHardwareAccess(accessType: .Gallery) { (isGranted) in
            if isGranted{
                self.delegate?.permissionControllerDidFinish(self)
            }
        }
    }
    
    
    //MARK:- View Delegate Method(s)
    func permissionViewSettingsButtonTapped(_ view: TDMediaPermissionView) {
        DispatchQueue.main.async {
            if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    func permissionViewCloseButtonTapped(_ view: TDMediaPermissionView) {
        self.delegate?.permissionControllerDidTapClose(self)
    }
    
}
