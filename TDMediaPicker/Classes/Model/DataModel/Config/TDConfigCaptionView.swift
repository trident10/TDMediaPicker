//
//  TDConfigAlbumScreen.swift
//  Pods
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//
import Foundation

open class TDConfigCaptionView: NSObject{
    var textConfig: TDConfigText?
    var backgroundColor: UIColor?
    
    public init(textConfig: TDConfigText? = nil, backgroundColor: UIColor? = nil){
        super.init()
        self.textConfig = textConfig
        self.backgroundColor = backgroundColor
    }
}

