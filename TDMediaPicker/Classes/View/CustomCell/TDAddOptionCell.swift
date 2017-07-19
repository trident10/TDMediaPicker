//
//  TDMediaCellImage.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

class TDAddOptionCell: UICollectionViewCell{
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    static func registerCell(_ collectionView: UICollectionView){
        collectionView.register(UINib.init(nibName: String(describing: self), bundle: TDMediaUtil.xibBundle()), forCellWithReuseIdentifier: String(describing: self))
    }

    
    // MARK: - Config
    
    // MARK: - Controls
}
