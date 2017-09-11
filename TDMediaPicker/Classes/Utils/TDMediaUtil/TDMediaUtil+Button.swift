//
//  TDMediaUtil+Button.swift
//  Pods
//
//  Created by Yapapp on 01/09/17.
//
//

import UIKit

extension TDMediaUtil {
    
    static func setupButton(_ button: UIButton, buttonConfig: TDConfigButton){
        
        if buttonConfig is TDConfigButtonImage{
            let buttonConfigImage = buttonConfig as! TDConfigButtonImage
            TDMediaUtil.setupImageButtonConfig(button, config: buttonConfigImage)
        }
        
        if buttonConfig is TDConfigButtonText{
            let buttonConfigText = buttonConfig as! TDConfigButtonText
            TDMediaUtil.setupTitleButtonConfig(button, config: buttonConfigText)
        }
        
        if let cornerRadius = buttonConfig.cornerRadius{
            button.layer.cornerRadius = cornerRadius
            button.clipsToBounds = true
        }
        
    }
    
    static func setupImageButtonConfig(_ button: UIButton, config: TDConfigButtonImage){
        var normalImage = UIImage()
        var highlightedImage = UIImage()
        var selectedImage = UIImage()
        
        var btnSize = config.size
        if btnSize == nil{
            btnSize = button.frame.size
        }
        
        if let image = config.normalImage{
            normalImage = resizeImage(image, newSize: btnSize!)
        }
        if let image = config.highlightImage{
            highlightedImage = resizeImage(image, newSize: btnSize!)
        }
        if let image = config.selectedImage{
            selectedImage = resizeImage(image, newSize: btnSize!)
        }
        
        button.setTitle("", for: .normal)
        button.setTitle("", for: .highlighted)
        button.setTitle("", for: .selected)
        
        button.setImage(normalImage, for: .normal)
        button.setImage(highlightedImage, for: .highlighted)
        button.setImage(selectedImage, for: .selected)
        
    }
    
    static func setupTitleButtonConfig(_ button: UIButton, config: TDConfigButtonText){
        //1. Title Setup
        var normalTitle = "Settings"
        var highlightedTitle = "Settings"
        var selectedTitle = "Settings"
        if let text = config.normalTextConfig?.text{
            normalTitle = text
            highlightedTitle = text
            selectedTitle = text
        }
        if let text = config.highlightTextConfig?.text{
            highlightedTitle = text
        }
        if let text = config.selectedTextConfig?.text{
            selectedTitle = text
        }
        button.setTitle(normalTitle, for: .normal)
        button.setTitle(highlightedTitle, for: .highlighted)
        button.setTitle(selectedTitle, for: .selected)
        
        //2. Set Button Title Font
        var normalTitleFont = UIFont.systemFont(ofSize: 14.0)
        if let font = config.normalTextConfig?.textFont{
            normalTitleFont = font
        }
        button.titleLabel?.font = normalTitleFont
        
        //2. Title Color Setup
        var normalTitleColor = UIColor.black
        var highlightedTitleColor = UIColor.black
        var selectedTitleColor = UIColor.black
        if let color = config.normalTextConfig?.textColor{
            normalTitleColor = color
            highlightedTitleColor = normalTitleColor
            selectedTitleColor = normalTitleColor
        }
        if let color = config.highlightTextConfig?.textColor{
            highlightedTitleColor = color
        }
        if let color = config.selectedTextConfig?.textColor{
            selectedTitleColor = color
        }
        button.setTitleColor(normalTitleColor, for: .normal)
        button.setTitleColor(highlightedTitleColor, for: .highlighted)
        button.setTitleColor(selectedTitleColor, for: .selected)
        
        //3. Color Setup
        var normalColor = UIColor.clear
        var highlightedColor = UIColor.clear
        var selectedColor = UIColor.clear
        if let color = config.normalColor{
            normalColor = color
            highlightedColor = color
            selectedColor = color
        }
        if let color = config.highlightedColor{
            highlightedColor = color
        }
        if let color = config.selectedColor{
            selectedColor = color
        }
        
        button.setBackgroundImage(getImagefromColor(color: normalColor), for: .normal)
        button.setBackgroundImage(getImagefromColor(color: highlightedColor), for: .highlighted)
        button.setBackgroundImage(getImagefromColor(color: selectedColor), for: .selected)
        
        //4. Set alpha for highlight buttons
        if normalColor.isEqual(highlightedColor) {
            highlightedColor = highlightedColor.withAlphaComponent(0.2)
            button.setBackgroundImage(getImagefromColor(color: highlightedColor), for: .highlighted)
            
            highlightedTitleColor = highlightedTitleColor.withAlphaComponent(0.3)
            button.setTitleColor(highlightedTitleColor, for: .highlighted)
        }
        
        //5. Content Inset Edges
        let insetAmount = 10 / 2
        button.contentEdgeInsets = UIEdgeInsets(top: CGFloat(insetAmount), left: CGFloat(insetAmount), bottom: CGFloat(insetAmount), right: CGFloat(insetAmount))
        
        //6. Button Size
        setupButtonCustomSize(button, config: config)
        
    }
    
    static func setupButtonCustomSize(_ button: UIButton, config: TDConfigButton){
        let btnSize = config.size
        if btnSize == nil{
            return
        }
        let currentsize = button.frame.size
        let requiredSize = btnSize
        let hightToAdd = (requiredSize?.height)! - currentsize.height
        let widthToAdd = (requiredSize?.width)! - currentsize.width
        button.contentEdgeInsets = UIEdgeInsets(top: CGFloat(hightToAdd/2), left: CGFloat(widthToAdd/2), bottom: CGFloat(hightToAdd/2), right: CGFloat(widthToAdd/2))
    }
    
}
