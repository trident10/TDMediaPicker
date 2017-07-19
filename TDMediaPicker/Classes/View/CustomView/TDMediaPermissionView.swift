//
//  TDMediaPermissionView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPermissionViewDelegate:class {
    func permissionViewSettingsButtonTapped(_ view: TDMediaPermissionView)
    func permissionViewCloseButtonTapped(_ view: TDMediaPermissionView)
}

class TDMediaPermissionView: UIView{
    
    weak var delegate:TDMediaPermissionViewDelegate?
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func settingsButtonTapped(){
        delegate?.permissionViewSettingsButtonTapped(self)
    }
    
    @IBAction func closeButtonTapped(){
        delegate?.permissionViewCloseButtonTapped(self)
    }
}
