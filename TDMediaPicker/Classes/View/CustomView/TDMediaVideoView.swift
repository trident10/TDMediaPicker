//
//  TDMediaVideoView.swift
//  Pods
//
//  Created by Abhimanu Jindal on 27/07/17.
//
//

import UIKit
import Photos

class TDMediaVideoView: UIView {
    
    private var avPlayerLayer: AVPlayerLayer?
    private var avPlayer: AVPlayer?
    private var mediaURL: URL?
    private var asset: PHAsset?

    
    @IBAction func playBtnTapped(sender: UIButton){
        updateView(displayVideo: true)
        self.avPlayer?.seek(to: kCMTimeZero)
        self.avPlayer?.play()
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

    
    private func updateView(displayVideo: Bool){
        self.avPlayerLayer?.isHidden = !displayVideo
    }

}
