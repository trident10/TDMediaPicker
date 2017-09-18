//
//  HightLightedCellView.swift
//  TDMediaPicker
//
//  Created by Ajay Kumar on 14/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class HightLightedCellView: UIView {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
