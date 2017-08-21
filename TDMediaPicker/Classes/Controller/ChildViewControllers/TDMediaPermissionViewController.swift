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
    func permissionControllerDidRequestForConfig(_ controller: TDMediaPermissionViewController)-> TDConfigPermissionScreen?

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
    
    func setupPermissionConfig(){
        let config = self.delegate?.permissionControllerDidRequestForConfig(self)
        if config == nil{
            return
        }
        if let customView = config?.customView{
            permissionView?.setupCustomView(view: customView)
            return
        }
        if let standardView = config?.standardView{
            permissionView?.setupStandardView(view: standardView)
            return
        }
        
    }
    
    private func requestGalleryPermission(){
        TDMediaUtil.requestForHardwareAccess(accessType: .Gallery) { (isGranted) in
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
        
    }
    
}
