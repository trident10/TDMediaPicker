//
//  TDConfig.swift
//  Pods
//
//  Created by Yapapp on 11/08/17.
//
//

import Foundation


open class TDConfigButton: TDConfig{
    
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
    
    public init(normalColor: UIColor? = nil, highlightedColor: UIColor? = nil, selectedColor: UIColor? = nil, normalTextConfig: TDConfigText? = nil, highlightTextConfig: TDConfigText? = nil, selectedTextConfig: TDConfigText? = nil) {
        super.init()
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
        self.selectedColor = selectedColor
        
        self.normalTextConfig = normalTextConfig
        self.highlightTextConfig = highlightTextConfig
        self.selectedTextConfig = selectedTextConfig
    }
}

open class TDConfigButtonImage: TDConfigButton{
    
    var normalImage: UIImage?
    var highlightImage: UIImage?
    var selectedImage: UIImage?
    
    public init(normalImage: UIImage? = nil, highlightImage: UIImage? = nil , selectedImage: UIImage? = nil) {
        super.init()
        self.normalImage = normalImage
        self.highlightImage = highlightImage
        self.selectedImage = selectedImage
    }
}

open class TDConfigButtonCustom: TDConfigButton{
    
    var button: UIButton
    
    init(button: UIButton) {
        self.button = button
    }
}
