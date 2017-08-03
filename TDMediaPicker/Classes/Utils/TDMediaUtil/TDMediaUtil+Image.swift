//
//  File.swift
//  Pods
//
//  Created by Abhimanu Jindal on 27/07/17.
//
//

import Foundation

extension TDMediaUtil {
    
    static func isImageResolutionValid(_ imageView:UIImageView, image: UIImage)-> Bool{
        let heightInPoints = image.size.height
        let widthInPoints = image.size.width
        return heightInPoints >= imageView.frame.size.height && widthInPoints >= imageView.frame.size.width
    }
    
}
