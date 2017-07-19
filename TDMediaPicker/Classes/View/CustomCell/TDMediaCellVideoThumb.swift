//
//  TDMediaCellVideoThumb.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 03/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

class TDMediaCellVideoThumb: TDMediaCell{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }

    
    // MARK: - Config
    
    override func configure(_ asset: PHAsset) {
        imageView.layoutIfNeeded()
        TDMediaUtil.fetchImage(asset, targetSize: self.frame.size, completionHandler: { (image, error) in
            if image != nil{
                self.imageView.image = image
            }
        })
    }
    
    override func didEndDisplay() {
        
    }
    
    override func willInitiateDisplay(){
        
    }
    
    override func processHighlighting(shouldDisplay: Bool, count: Int = -1, text: String = ""){
        if shouldDisplay{
            label.text = String(count)
            imageView.isHidden = true
            return
        }
        label.text = ""
        imageView.isHidden = false
    }
}

