//
//  TDAlbumCell.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

class TDAlbumCell: UITableViewCell{
    
    // MARK: - Variables
    
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    
    private var requestID: PHImageRequestID?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      //  fatalError("init(coder:) has not been implemented")

    }
    
    // MARK: - Config
    
    func configure(_ album: TDAlbumViewModel, completionHandler: ((_ image: UIImage)->Void)?) {
        
        titleLabel.text = album.title
        countLabel.text = album.countTitle
            
        requestID = TDMediaUtil.fetchImage(album.asset, targetSize: albumImageView.frame.size, completionHandler: { (image, error) in
            if image != nil{
                self.albumImageView.image = image
                let heightInPoints = image!.size.height
                let widthInPoints = image!.size.width
                if heightInPoints >= self.albumImageView.frame.size.height && widthInPoints >= self.albumImageView.frame.size.width {
                    completionHandler?(image!)
                }
            }
        })
    }
    
    func configure(_ album: TDAlbumViewModel, image: UIImage) {
        
        titleLabel.text = album.title
        countLabel.text = album.countTitle
        
        albumImageView.layoutIfNeeded()
        albumImageView.image = image
    }
    
    func purgeCell(){
        if requestID != nil{
            TDMediaUtil.cancelImageRequest(requestID: requestID!)
        }
    }
}
