//
//  TDConfig.swift
//  Pods
//
//  Created by Yapapp on 11/08/17.
//
//

import Foundation

open class TDConfigText: TDConfig{
    
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
