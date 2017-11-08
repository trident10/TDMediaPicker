//
//  TDConfigLabel.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import UIKit

public struct TDConfigLabel{
    
    var textConfig: TDConfigText?
    var backgroundColor: UIColor?
    var textAlignment: NSTextAlignment?
    var lineBreakMode: NSLineBreakMode?
    var minimumFontSize: CGFloat?
    
    public init(backgroundColor: UIColor? = nil, textConfig: TDConfigText? = nil, textAlignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil, minimumFontSize: CGFloat? = nil) {
        self.textConfig = textConfig
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.minimumFontSize = minimumFontSize
    }
}

