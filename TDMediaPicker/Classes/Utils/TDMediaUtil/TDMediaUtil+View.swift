//
//  TDMediaUtil+Label.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import Foundation

extension TDMediaUtil {
    static func setupView(_ view: UIView, _ config: TDConfigViewCustom){
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
        view.backgroundColor = .clear
        config.view.frame = view.bounds
        view.addSubview(config.view)
        self.pinEdges(sourceView: config.view)
    }
    static func setupView(_ view: UIView, _ config: TDConfigViewStandard){
        view.backgroundColor = config.backgroundColor
    }
    static func setupView(_ view: UIView, _ config: TDConfigView){
        if config is TDConfigViewStandard{
            self.setupView(view, config as!TDConfigViewStandard)
        }else{
            self.setupView(view, config as!TDConfigViewCustom)
        }
    }
}
