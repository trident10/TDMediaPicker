//
//  TDMediaPermissionView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 24/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPermissionViewDelegate:class {
    func permissionViewSettingsButtonTapped(_ view: TDMediaPermissionView)
    func permissionViewCloseButtonTapped(_ view: TDMediaPermissionView)
}

class TDMediaPermissionView: TDMediaPickerView{
    
    @IBOutlet var lblCaption: UILabel!
    @IBOutlet var btnSettings: UIButton!
    @IBOutlet var btnCancel: UIButton!
    
    weak var delegate:TDMediaPermissionViewDelegate?
    
    override func awakeFromNib() {
        
    }
    
    override func setupTheme() {
        
    }
    
    //MARK: - Public Method(s)
    
    func setupCustomView(view: TDConfigView){
        let tempViewConfig = view as! TDConfigViewCustom
        let tempView = tempViewConfig.view
        tempView.frame = CGRect.init(x: 0, y: 0, width: tempView.frame.width, height: tempView.frame.height)
        self.addSubview(tempView)
    }
    
    func setupStandardView(view: TDConfigView){
        let tempViewConfig = view as! TDConfigViewStandard
        self.backgroundColor = tempViewConfig.backgroundColor
    }
    
    func setupSettingsButton(buttonConfig: TDConfigButton){
        if buttonConfig is TDConfigButtonCustom{
            print("Custom")
        }
        
        if buttonConfig is TDConfigButtonImage{
            let buttonConfigImage = buttonConfig as! TDConfigButtonImage
            setupImageButtonConfig(config: buttonConfigImage)
        }
        
        if buttonConfig is TDConfigButtonText{
            let buttonConfigText = buttonConfig as! TDConfigButtonText
            setupTitleButtonConfig(config: buttonConfigText)
        }
    }
    
    
    //MARK: - Private Method(s)
    
    private func setupImageButtonConfig(config: TDConfigButtonImage){
        var normalImage = UIImage()
        var highlightedImage = UIImage()
        var selectedImage = UIImage()
        
        if let image = config.normalImage{
            normalImage = image
        }
        if let image = config.highlightImage{
            highlightedImage = image
        }
        if let image = config.selectedImage{
            selectedImage = image
        }

        btnSettings.setTitle("", for: .normal)
        btnSettings.setTitle("", for: .highlighted)
        btnSettings.setTitle("", for: .selected)
        
        btnSettings.imageView?.contentMode = .scaleAspectFit
        
        btnSettings.setImage(normalImage, for: .normal)
        btnSettings.setImage(highlightedImage, for: .highlighted)
        btnSettings.setImage(selectedImage, for: .selected)
        
        
    }
    
    private func setupTitleButtonConfig(config: TDConfigButtonText){
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
        btnSettings.setTitle(normalTitle, for: .normal)
        btnSettings.setTitle(highlightedTitle, for: .highlighted)
        btnSettings.setTitle(selectedTitle, for: .selected)
        
        //2. Set Button Title Font
        var normalTitleFont = UIFont.systemFont(ofSize: 14.0)
        if let font = config.normalTextConfig?.textFont{
            normalTitleFont = font
        }
        btnSettings.titleLabel?.font = normalTitleFont
        
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
        btnSettings.setTitleColor(normalTitleColor, for: .normal)
        btnSettings.setTitleColor(highlightedTitleColor, for: .highlighted)
        btnSettings.setTitleColor(selectedTitleColor, for: .selected)
        
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
        
        btnSettings.setBackgroundImage(getImagefromColor(color: normalColor), for: .normal)
        btnSettings.setBackgroundImage(getImagefromColor(color: highlightedColor), for: .highlighted)
        btnSettings.setBackgroundImage(getImagefromColor(color: selectedColor), for: .selected)
        
        //4. Set alpha for highlight buttons
        if normalColor.isEqual(highlightedColor) {
            highlightedColor = highlightedColor.withAlphaComponent(0.05)
            btnSettings.setBackgroundImage(getImagefromColor(color: highlightedColor), for: .highlighted)
            
            highlightedTitleColor = highlightedColor.withAlphaComponent(0.05)
            btnSettings.setTitleColor(highlightedTitleColor, for: .highlighted)
        }
        
        //5. Content Inset Edges
        let insetAmount = 10 / 2
        btnSettings.contentEdgeInsets = UIEdgeInsets(top: CGFloat(insetAmount), left: CGFloat(insetAmount), bottom: CGFloat(insetAmount), right: CGFloat(insetAmount))
    }
    
    private func getImagefromColor(color: UIColor)-> UIImage{
        let rect = CGRect(x:0.0,y:0.0,width: 1.0,height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        context?.setAlpha(CGFloat(alpha))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //MARK: - Action Method(s)
    
    @IBAction func settingsButtonTapped(){
        delegate?.permissionViewSettingsButtonTapped(self)
    }
    
    @IBAction func closeButtonTapped(){
        delegate?.permissionViewCloseButtonTapped(self)
    }
}
