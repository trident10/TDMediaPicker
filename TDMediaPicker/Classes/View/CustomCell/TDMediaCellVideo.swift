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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var btnPlay: UIButton!
    
    private var avPlayerLayer: AVPlayerLayer?
    private var avPlayer: AVPlayer?
    private var mediaURL: URL?
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
        
        purgeVideoLayer()
    }
    
    override func prepareForReuse(){
        purgeVideoLayer()
    }
    
    
    // MARK: - IBAction Method(s)
    
    @IBAction func playBtnTapped(sender: UIButton){
        updateView(displayVideo: true)
        self.avPlayer?.seek(to: kCMTimeZero)
        self.avPlayer?.play()
    }
    
    // MARK: - Private Method(s)
    
    private func updateView(displayVideo: Bool){
        imageView.isHidden = displayVideo
        btnPlay.isHidden = displayVideo
        self.avPlayerLayer?.isHidden = !displayVideo
    }
    
    private func stopPlayer(){
        avPlayer?.pause()
        avPlayer?.seek(to: kCMTimeZero)
    }
    
    private func purgeVideoLayer(){
        self.avPlayerLayer?.removeFromSuperlayer()
        avPlayerLayer = nil
        mediaURL = nil
        stopPlayer()
        avPlayer = nil
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc private func playerItemDidPlayToEndTime(){
        stopPlayer()
        updateView(displayVideo: false)
    }
    
    private func setupVideoPlayer(_ completion: @escaping (Void) -> Void){
        
        if self.avPlayerLayer != nil{
            purgeVideoLayer()
        }
        
        TDMediaUtil.fetchPlayerItem(self.asset!) { (playerItem) in
            
            if playerItem != nil{
                
                self.avPlayer = AVPlayer(playerItem: playerItem!)
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                self.avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
                self.avPlayerLayer?.backgroundColor = UIColor.green.cgColor
                self.avPlayerLayer!.frame = self.bounds
                self.avPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                self.layer.addSublayer(self.avPlayerLayer!)
                self.avPlayerLayer?.isHidden = true
                completion()
            }
        }
    }
    
    
    // MARK: - Config
    
    override func configure(_ asset: PHAsset) {
        imageView.layoutIfNeeded()
        self.asset = asset
        TDMediaUtil.fetchImage(asset, targetSize: self.frame.size, completionHandler: { (image, error) in
            if image != nil{
                self.imageView.image = image
            }
        })
    }
    
    override func didEndDisplay() {
        stopPlayer()
        updateView(displayVideo: false)
    }
    
    override func willInitiateDisplay(){
        print("Starting Vieo Player Setup")
        setupVideoPlayer {
            print("Vieo Player Setup Succeed")
        }
    }
    
    override func processHighlighting(shouldDisplay: Bool, count: Int = -1, text: String = ""){
        fatalError("This should be implemented by concrete class")
    }
}
