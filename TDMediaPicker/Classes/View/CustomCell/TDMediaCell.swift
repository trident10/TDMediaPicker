//
//  TDMediaCell.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 03/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos


class TDMediaCell: UICollectionViewCell{
    
    // MARK: - Variable
    
    enum CellType{
        case Image, ImageThumb, Video, VideoThumb
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    static func mediaCellWithType(_ type: TDMediaCell.CellType, collectionView: UICollectionView, for indexPath: IndexPath) -> TDMediaCell{
        
        switch type {
        
            case .Image:
                return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TDMediaCellImage.self), for: indexPath) as! TDMediaCell
            
            case .ImageThumb:
                return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TDMediaCellImageThumb.self), for: indexPath) as! TDMediaCell
            
            case .Video:
                return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TDMediaCellVideo.self), for: indexPath) as! TDMediaCell
            
            case .VideoThumb:
                return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TDMediaCellVideoThumb.self), for: indexPath) as! TDMediaCell
                
        }
    }
    
    static func registerCellWithType(_ type: TDMediaCell.CellType, collectionView: UICollectionView){
        switch type {
        case .Image:
            collectionView.register(UINib.init(nibName: String(describing: TDMediaCellImage.self), bundle: TDMediaUtil.xibBundle()), forCellWithReuseIdentifier: String(describing: TDMediaCellImage.self))
        case .ImageThumb:
            collectionView.register(UINib.init(nibName: String(describing: TDMediaCellImageThumb.self), bundle: TDMediaUtil.xibBundle()), forCellWithReuseIdentifier: String(describing: TDMediaCellImageThumb.self))
        case .Video:
            collectionView.register(UINib.init(nibName: String(describing: TDMediaCellVideo.self), bundle: TDMediaUtil.xibBundle()), forCellWithReuseIdentifier: String(describing: TDMediaCellVideo.self))

        case .VideoThumb:
            collectionView.register(UINib.init(nibName: String(describing: TDMediaCellVideoThumb.self), bundle: TDMediaUtil.xibBundle()), forCellWithReuseIdentifier: String(describing: TDMediaCellVideoThumb.self))
        }
    }
    
    func configure(_ asset: PHAsset) {
        fatalError("This should be implemented by concrete class")
    }
    
    func willInitiateDisplay(){
        fatalError("This should be implemented by concrete class")
    }
    
    func didEndDisplay(){
        fatalError("This should be implemented by concrete class")
    }
    
    func processHighlighting(shouldDisplay: Bool, count: Int = -1, text: String = ""){
        fatalError("This should be implemented by concrete class")
    }
    
}
