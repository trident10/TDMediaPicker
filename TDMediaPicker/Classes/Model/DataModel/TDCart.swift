//
//  TDCart.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 27/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

class TDCart{
    
    enum UpdateType {
        case add
        case delete
        case reload
        case purgeCache
    }
    
    public var media: [TDMedia] = []
    
    // MARK: - Initialization
    
    init() {
        
    }
}
