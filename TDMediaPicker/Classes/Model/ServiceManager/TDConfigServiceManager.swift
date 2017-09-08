//
//  TDConfigServiceManager.swift
//  Pods
//
//  Created by Yapapp on 17/08/17.
//
//

import Foundation

class TDConfigServiceManager{
    
    // MARK: - Variable(s)
    
    static let sharedInstance = TDConfigServiceManager()
    
    lazy var navigationTheme: TDConfigViewStandard = TDConfigViewStandard.init(backgroundColor: .white)
    lazy var albumScreenConfig = TDConfigAlbumScreen()
}
