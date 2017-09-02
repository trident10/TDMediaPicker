//
//  TDConfigLabel.swift
//  Pods
//
//  Created by Yapapp on 02/09/17.
//
//

import UIKit

open class TDConfigLabel: TDConfig{
    
    var textConfig: TDConfigText?
    var backgroundColor: UIColor?
    var textAlignment: NSTextAlignment?
    var lineBreakMode: NSLineBreakMode?
    var minimumFontSize: CGFloat?
    
    public init(backgroundColor: UIColor? = nil, textConfig: TDConfigText? = nil, textAlignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode? = nil, minimumFontSize: CGFloat? = nil) {
        super.init()
        self.textConfig = textConfig
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.minimumFontSize = minimumFontSize
    }
}

