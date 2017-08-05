//
//  TDMediaPreviewViewController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPreviewViewControllerDelegate: class {
    func previewControllerDidTapClose(_ controller: TDMediaPreviewViewController)
    func previewControllerDidTapAddOption(_ controller: TDMediaPreviewViewController)
    func previewControllerDidTapDone(_ controller: TDMediaPreviewViewController)
}

class TDMediaPreviewViewController: UIViewController, TDMediaPreviewViewDelegate, TDMediaPreviewServiceManagerDelegate{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewViewControllerDelegate?

    lazy private var serviceManager: TDMediaPreviewServiceManager = TDMediaPreviewServiceManager()

    // MARK: - Init
    
    public required init() {
        super.init(nibName: "TDMediaPreview", bundle: TDMediaUtil.xibBundle())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. View Setup
        
        let previewView = self.view as! TDMediaPreviewView
        previewView.delegate = self
        
        // 3. Service Manager Setup
        
        serviceManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        serviceManager.fetchMediaItems()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        serviceManager.purgeData()
        
        let previewView = self.view as! TDMediaPreviewView
        previewView.purgeData()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let previewView = self.view as! TDMediaPreviewView
        previewView.previewView.viewWillTransition()
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            previewView.previewView.viewDidTransition()
            previewView.bottomView.viewDidTransition()
        })
    }
    // MARK: - Private Method(s)
    
    private func mapMediaViewModels(mediaList:[TDMedia])->TDMediaPreviewViewModel{
        var mediaViewModels: [TDPreviewViewModel] = []
        for(_,media) in mediaList.enumerated(){
            let mediaViewModel = map(media)
            if mediaViewModel != nil{
                let mediaView = mediaViewModel as! TDPreviewViewModel
                mediaViewModels.append(mediaView)
            }
        }
        let media = TDMediaPreviewViewModel()
        media.previewMedia = mediaViewModels
        return media
    }
    
    private func mapMediaModels(mediaList:[TDMedia])->TDMediaPreviewViewModel{
        var mediaViewModels: [TDPreviewViewModel] = []
        for(_,media) in mediaList.enumerated(){
            let mediaViewModel = map(media)
            if mediaViewModel != nil{
                let mediaView = mediaViewModel as! TDPreviewViewModel
                mediaViewModels.append(mediaView)
            }
        }
        let media = TDMediaPreviewViewModel()
        media.previewMedia = mediaViewModels
        return media
    }
    
    private func map<T>(_ from: T) -> AnyObject?{
        if from is TDMedia{
            let media = from as! TDMedia
            return TDPreviewViewModel.init(id: media.id, asset: media.asset, itemType: .Media)
        }
        return nil
    }
    
    
    // MARK: - View Delegate Method(s)
    
    func previewView(_ view: TDMediaPreviewView, didUpdateOperation type: TDMediaPreviewViewModel.OperationType) {
        switch type {
        case .close:
            self.delegate?.previewControllerDidTapClose(self)
        case .addMore:
            self.delegate?.previewControllerDidTapAddOption(self)
        case .done:
            self.delegate?.previewControllerDidTapDone(self)
        }
    }
    
    func previewView(_ view: TDMediaPreviewView, didRequestDeleteMedia media: TDPreviewViewModel){
        
        serviceManager.fetchMedia(media.id) { (mediaDataModel) in
            if mediaDataModel == nil{
                return
            }
            let previewView = self.view as! TDMediaPreviewView
            if previewView.previewView.getMedia().count <= 1{
                self.delegate?.previewControllerDidTapClose(self)
            }
            self.serviceManager.updateCart(mediaDataModel!, updateType: .delete)
        }
    }
    
    
    // MARK: - Service Manager Deleage Method(s)
    
    func mediaPreviewServiceManager(_ manager: TDMediaPreviewServiceManager, didUpdateCart cart: TDCart, updateType: TDCart.UpdateType, shouldDisplayAddMoreOption: Bool) {
        
        let mediaViewModels = mapMediaViewModels(mediaList: cart.media)
        let previewView = self.view as! TDMediaPreviewView
        previewView.reload(media: mediaViewModels, shouldDisplayAddMoreOption: shouldDisplayAddMoreOption)
    }
    
    
}
