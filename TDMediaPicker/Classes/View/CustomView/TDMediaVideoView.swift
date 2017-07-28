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
    
    // MARK: - Variable(s)
    
    private var avPlayerLayer: AVPlayerLayer?
    private var avPlayer: AVPlayer?
    private var asset: PHAsset?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Video Deinit")
    }
    // MARK: - Public Method(s)
    
    func playVideo(){
        self.avPlayer?.seek(to: kCMTimeZero)
        self.avPlayer?.play()
    }
    
    func purgeVideoPlayer(_ completion: @escaping (Void) -> Void){
        if self.avPlayerLayer != nil{
            self.purgeVideoLayer {
                completion()
                return
            }
            return
        }
        completion()
    }
    
    func setupVideoPlayer(_ asset: PHAsset, completion: @escaping (Void) -> Void){
        self.asset = asset
        purgeVideoPlayer {
            self.setupPlayer {
                completion()
            }
        }
    }
    
    // MARK: - Private Method(s)
    
    private func setupPlayer(_ completion: @escaping (Void) -> Void){
        TDMediaUtil.fetchPlayerItem(self.asset!) { (playerItem) in
            
            if playerItem != nil{
                
                self.avPlayer = AVPlayer(playerItem: playerItem!)
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                self.avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
                self.avPlayerLayer?.backgroundColor = UIColor.green.cgColor
                self.avPlayerLayer!.frame = self.bounds
                self.avPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                self.layer.addSublayer(self.avPlayerLayer!)
                completion()
            }
        }
    }
    
    private func stopPlayer(){
        avPlayer?.pause()
        avPlayer?.seek(to: kCMTimeZero)
    }
    
    private func purgeVideoLayer(_ completion: @escaping (Void) -> Void){
        self.avPlayerLayer?.removeFromSuperlayer()
        avPlayerLayer = nil
        stopPlayer()
        avPlayer = nil
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        completion()
    }
    
    @objc private func playerItemDidPlayToEndTime(){
        stopPlayer()
    }

}
