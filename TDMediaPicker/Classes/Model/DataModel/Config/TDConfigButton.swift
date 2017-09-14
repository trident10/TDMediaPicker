//
//  TDConfig.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation


open class TDConfigButton: TDConfig{
    open var size: CGSize?
    open var cornerRadius: CGFloat?
    public override init() {
        super.init()
    }
}

open class TDConfigButtonText: TDConfigButton{
    
    open var normalColor: UIColor?
    open var highlightedColor: UIColor?
    open var selectedColor: UIColor?
    open var disabledColor: UIColor?
    
    open var normalTextConfig: TDConfigText?
    open var highlightTextConfig: TDConfigText?
    open var selectedTextConfig: TDConfigText?
    open var disabledTextConfig: TDConfigText?
    
    public init(normalColor: UIColor? = nil, highlightedColor: UIColor? = nil, selectedColor: UIColor? = nil, normalTextConfig: TDConfigText? = nil, highlightTextConfig: TDConfigText? = nil, selectedTextConfig: TDConfigText? = nil, customSize: CGSize? = nil, cornerRadius: CGFloat? = nil) {
        super.init()
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

open class TDConfigButtonImage: TDConfigButton{
    
    open var normalImage: UIImage?
    open var highlightImage: UIImage?
    open var selectedImage: UIImage?
    open var disabledImage: UIImage?
    
    public init(normalImage: UIImage? = nil, highlightImage: UIImage? = nil , selectedImage: UIImage? = nil, customSize: CGSize? = nil, cornerRadius: CGFloat? = nil) {
        super.init()
        self.normalImage = normalImage
        self.highlightImage = highlightImage
        self.selectedImage = selectedImage
        self.cornerRadius = cornerRadius
        self.size = customSize
    }
}
