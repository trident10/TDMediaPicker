//
//  TDConfig.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation


public protocol TDConfigButton{
    var size: CGSize? {get set}
    var cornerRadius: CGFloat? {get set}
}

public struct TDConfigButtonText: TDConfigButton{
    public var size: CGSize?
    
    public var cornerRadius: CGFloat?
    
    
    public var normalColor: UIColor?
    public var highlightedColor: UIColor?
    public var selectedColor: UIColor?
    public var disabledColor: UIColor?
    
    public var normalTextConfig: TDConfigText?
    public var highlightTextConfig: TDConfigText?
    public var selectedTextConfig: TDConfigText?
    public var disabledTextConfig: TDConfigText?
    
    public init(normalColor: UIColor? = nil, highlightedColor: UIColor? = nil, selectedColor: UIColor? = nil, normalTextConfig: TDConfigText? = nil, highlightTextConfig: TDConfigText? = nil, selectedTextConfig: TDConfigText? = nil, customSize: CGSize? = nil, cornerRadius: CGFloat? = nil) {
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
        self.selectedColor = selectedColor
        self.cornerRadius = cornerRadius
        
        self.normalTextConfig = normalTextConfig
        self.highlightTextConfig = highlightTextConfig
        self.selectedTextConfig = selectedTextConfig
        
        self.size = customSize
    }
}

public struct TDConfigButtonImage: TDConfigButton{
    public var size: CGSize?
    
    public var cornerRadius: CGFloat?
    
    
    public var normalImage: UIImage?
    public var highlightImage: UIImage?
    public var selectedImage: UIImage?
    public var disabledImage: UIImage?
    
    public init(normalImage: UIImage? = nil, highlightImage: UIImage? = nil , selectedImage: UIImage? = nil, customSize: CGSize? = nil, cornerRadius: CGFloat? = nil) {
        self.normalImage = normalImage
        self.highlightImage = highlightImage
        self.selectedImage = selectedImage
        self.cornerRadius = cornerRadius
        self.size = customSize
    }
}
