//
//  TDConfig.swift
//  Pods
//
//  Created by Yapapp on 11/08/17.
//
//

import Foundation


open class TDConfigButton: TDConfig{
    var size: CGSize?
    var cornerRadius: CGFloat?
    public override init() {
        super.init()
    }
}

open class TDConfigButtonText: TDConfigButton{
    
    var normalColor: UIColor?
    var highlightedColor: UIColor?
    var selectedColor: UIColor?
    
    var normalTextConfig: TDConfigText?
    var highlightTextConfig: TDConfigText?
    var selectedTextConfig: TDConfigText?
    
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
    
    var normalImage: UIImage?
    var highlightImage: UIImage?
    var selectedImage: UIImage?
    
    public init(normalImage: UIImage? = nil, highlightImage: UIImage? = nil , selectedImage: UIImage? = nil, customSize: CGSize? = nil, cornerRadius: CGFloat? = nil) {
        super.init()
        self.normalImage = normalImage
        self.highlightImage = highlightImage
        self.selectedImage = selectedImage
        self.cornerRadius = cornerRadius
        self.size = customSize
    }
}
