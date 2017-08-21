//
//  TDConfig.swift
//  Pods
//
//  Created by Yapapp on 11/08/17.
//
//

import Foundation

open class TDConfigView: TDConfig{
    public override init() {
        super.init()
    }
}

open class TDConfigViewStandard: TDConfigView{
    
    open var backgroundColor: UIColor
    
    public init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}

open class TDConfigViewCustom: TDConfigView{
    
    open var view: UIView = UIView.init()
    
    public init(view: UIView) {
        super.init()
        self.view = view
    }
}
