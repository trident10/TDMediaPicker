//
//  TDConfig.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

open struct TDTextConfig{
    
    open var textColor: UIColor?
    open var text: String = ""
    open var textFont: UIFont?
    
    public init(text: String ,textColor: UIColor? = nil, textFont: UIFont? = nil) {
        super.init()
        self.text = text
        self.textColor = textColor
        self.textFont = textFont
    }
}
