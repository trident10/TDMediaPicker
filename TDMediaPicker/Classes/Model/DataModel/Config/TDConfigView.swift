//
//  TDConfig.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

public protocol TDConfigView{
}

public struct TDConfigViewStandard: TDConfigView{
    
    public var backgroundColor: UIColor
    
    public init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}

public struct TDConfigViewCustom: TDConfigView{
    
    public var view: UIView = UIView.init()
    
    public init(view: UIView) {
        self.view = view
    }
}
