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
    
    var normalColor: UIColor = .white
    var selectedColor: UIColor = .blue
    
    var normalTextConfig: TDConfigText = TDConfigText(text: "")
    var selectedTextConfig: TDConfigText = TDConfigText(text: "")
    
    public init(normalColor: UIColor, selectedColor: UIColor, normalTextConfig: TDConfigText, selectedTextConfig: TDConfigText) {
        super.init()
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        
        self.normalTextConfig = normalTextConfig
        self.selectedTextConfig = selectedTextConfig
    }
}

open class TDConfigButtonImage: TDConfigButton{
    
    var normalImage: UIImage
    var selectedImage: UIImage
    
    init(normalImage: UIImage, selectedImage: UIImage) {
        self.normalImage = normalImage
        self.selectedImage = selectedImage
    }
}

open class TDConfigButtonCustom: TDConfigButton{
    
    var button: UIButton
    
    init(button: UIButton) {
        self.button = button
    }
}
