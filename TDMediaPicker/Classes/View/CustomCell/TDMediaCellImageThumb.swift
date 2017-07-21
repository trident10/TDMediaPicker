//
//  TDMediaCellImageThumb.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

class TDMediaCellImageThumb: TDMediaCell{
    
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
    
    override func configure(_ asset: PHAsset, completionHandler: ((_ image: UIImage)->Void)?) {
        imageView.layoutIfNeeded()
        _ = TDMediaUtil.fetchImage(asset, targetSize: self.frame.size, completionHandler: { (image, error) in
            if image != nil{
                self.imageView.image = image
                let heightInPoints = image!.size.height
                let widthInPoints = image!.size.width
                if heightInPoints >= self.imageView.frame.size.height && widthInPoints >= self.imageView.frame.size.width {
                    completionHandler?(image!)
                }
            }
        })
    }
    
    override func configure(_ image: UIImage) {
        imageView.layoutIfNeeded()
        imageView.image = image
    }
    
    override func didEndDisplay() {
        
    }
    
    override func willInitiateDisplay(){
        
    }
    
    override func processHighlighting(shouldDisplay: Bool, count: Int = -1, text: String = ""){
        if shouldDisplay{
            
            label.text = count == -1 ? "" : String(count)
            imageView.isHidden = true
            return
        }
        label.text = ""
        imageView.isHidden = false
    }
}
