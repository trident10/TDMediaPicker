//
//  TDMediaCellVideo.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 26/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
import Photos

class TDMediaCellVideo: TDMediaCell{
    
    @IBOutlet var btnPlay: UIButton!
    
    private var asset: PHAsset?

    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    deinit {
        
        print("Video CEll REMOVED")
    }
    
    override func prepareForReuse(){
    }
    
    
    // MARK: - IBAction Method(s)
    
    @IBAction func playBtnTapped(sender: UIButton){
        updateView(displayVideo: true)
    }
    
    // MARK: - Private Method(s)
    
    private func updateView(displayVideo: Bool){
        imageView.isHidden = displayVideo
        btnPlay.isHidden = displayVideo
    }
    
    // MARK: - Config
    
    override func configure(_ asset: PHAsset, completionHandler: ((_ image: UIImage)->Void)?) {
        super.configure(asset, completionHandler: completionHandler)
        btnPlay.setImage(UIImage.init(named: "ic_play", in: TDMediaUtil.pngBundle(), compatibleWith: nil), for: .normal)
    }
    
    override func configure(_ image: UIImage) {
        super.configure(image)
    }
    
    override func didEndDisplay() {
        updateView(displayVideo: false)
    }
    
    override func willInitiateDisplay(){
        
    }
    
    override func processHighlighting(shouldDisplay: Bool, count: Int = -1, text: String = ""){
        fatalError("This should be implemented by concrete class")
    }
}
