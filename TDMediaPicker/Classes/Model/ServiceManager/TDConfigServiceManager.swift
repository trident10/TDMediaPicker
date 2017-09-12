//
//  TDConfigServiceManager.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

class TDConfigServiceManager{
    
    // MARK: - Variable(s)
    
    static let sharedInstance = TDConfigServiceManager()
    
    lazy var navigationTheme: TDConfigViewStandard = TDConfigViewStandard.init(backgroundColor: .white)
    lazy var albumScreenConfig = TDConfigAlbumScreen()
}
