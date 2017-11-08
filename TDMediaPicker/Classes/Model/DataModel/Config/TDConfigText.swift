//
//  TDConfig.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

public struct TDConfigText{
    
    public var textColor: UIColor?
    public var text: String = ""
    public var textFont: UIFont?
    
    public init(text: String ,textColor: UIColor? = nil, textFont: UIFont? = nil) {
        self.text = text
        self.textColor = textColor
        self.textFont = textFont
    }
}
