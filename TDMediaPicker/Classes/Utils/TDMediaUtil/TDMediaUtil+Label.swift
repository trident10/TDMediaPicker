//
//  TDMediaUtil+Label.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

extension TDMediaUtil {
    
    static func setupLabel(_ label: UILabel, config: TDConfigLabel){
        if let alignment = config.textAlignment{
            label.textAlignment = alignment
        }
        if let color = config.backgroundColor{
            label.backgroundColor = color
        }
        if let text = config.textConfig?.text{
            label.text = text
        }
        if let font = config.textConfig?.textFont{
            label.font = font
        }
        if let color = config.textConfig?.textColor{
            label.textColor = color
        }
        if let minimumFontSize = config.minimumFontSize{
            label.adjustsFontSizeToFitWidth = true
            let currentTextSize = label.font.pointSize
            var scale = minimumFontSize / currentTextSize
            if scale <= 0{
                scale = 0.1
            }
            label.minimumScaleFactor = scale
        }
    }
}
