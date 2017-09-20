//
//  TDMediaPreviewViewController.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
protocol TDMediaPreviewControllerDataSource: class {
    func previewControllerSelectedThumbnailView(_ controller: TDMediaPreviewViewController)-> TDConfigView?
    func previewControllerThumbnailAddView(_ controller: TDMediaPreviewViewController)-> TDConfigView?
    func previewControllerHideCaptionView(_ controller: TDMediaPreviewViewController)-> Bool?
    func previewControllerVideoThumbOverlay(_ controller: TDMediaPreviewViewController) -> TDConfigView?
}
protocol TDMediaPreviewViewControllerDelegate: class {
    func previewControllerDidTapClose(_ controller: TDMediaPreviewViewController)
    func previewControllerDidTapAddOption(_ controller: TDMediaPreviewViewController)
    func previewControllerDidTapDone(_ controller: TDMediaPreviewViewController)
}

class TDMediaPreviewViewController: UIViewController, TDMediaPreviewViewDelegate, TDMediaPreviewServiceManagerDelegate{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewViewControllerDelegate?
    weak var dataSource: TDMediaPreviewControllerDataSource?

    lazy fileprivate var serviceManager: TDMediaPreviewServiceManager = TDMediaPreviewServiceManager()

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
        previewView.dataSource = self
        
        // 3. Service Manager Setup
        
        serviceManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationTheme()
        setupConfig()

        serviceManager.fetchMediaItems()
        let previewView = self.view as! TDMediaPreviewView
        previewView.previewView.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        serviceManager.purgeData()
        
        let previewView = self.view as! TDMediaPreviewView
        previewView.purgeData()
        previewView.previewView.viewDidDisappear()
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
            return TDPreviewViewModel.init(id: media.id, asset: media.asset, itemType: .Media, caption:media.caption)
        }
        return nil
    }
    
    private func didRequestDeleteMedia(media: TDPreviewViewModel){
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
    
    private func didRequestEditMedia(media: TDPreviewViewModel){
        serviceManager.fetchMedia(media.id) { (mediaDataModel) in
            if mediaDataModel == nil{
                return
            }
            mediaDataModel?.caption = media.caption!
            self.serviceManager.updateCart(mediaDataModel!, updateType: .edit)
        }
    }
    
    
    // MARK: - View Delegate Method(s)
    
    func previewView(_ view: TDMediaPreviewView, didUpdateOperation type: TDMediaPreviewViewModel.OperationType, media: TDPreviewViewModel?) {
        switch type {
        case .close:
            self.delegate?.previewControllerDidTapClose(self)
        case .addMore:
            self.delegate?.previewControllerDidTapAddOption(self)
        case .done:
            self.delegate?.previewControllerDidTapDone(self)
        case .delete:
            self.didRequestDeleteMedia(media: media!)
        case .edit:
            self.didRequestEditMedia(media: media!)
        }
    }
    
    // MARK: - Service Manager Deleage Method(s)
    
    func mediaPreviewServiceManager(_ manager: TDMediaPreviewServiceManager, didUpdateCart cart: TDCart, updateType: TDCart.UpdateType, shouldDisplayAddMoreOption: Bool) {
        
        let mediaViewModels = mapMediaViewModels(mediaList: cart.media)
        let previewView = self.view as! TDMediaPreviewView
        previewView.reload(media: mediaViewModels, shouldDisplayAddMoreOption: shouldDisplayAddMoreOption)
    }
}

// MARK: - Configurations

extension TDMediaPreviewViewController{
    func setupNavigationTheme(){
        let config = serviceManager.getNavigationThemeConfig()
        let previewView = self.view as! TDMediaPreviewView
        previewView.setupNavigationTheme(config.backgroundColor)
    }
    
    func setupConfig(){
        let previewView = self.view as! TDMediaPreviewView
        let config = serviceManager.getPreviewScreenConfig()
        
        if let btnConfig = config.navigationBar?.otherButton{
            previewView.setupDeleteButton(btnConfig)
        }
        if let btnConfig = config.navigationBar?.backButton{
            previewView.setupBackButton(btnConfig)
        }
        if let btnConfig = config.navigationBar?.nextButton{
            previewView.setupNextButton(btnConfig)
        }
        if let color = config.navigationBar?.navigationBarView?.backgroundColor{
            previewView.setupNavigationTheme(color)
        }
    }
}
extension TDMediaPreviewViewController: TDMediaPreviewViewDataSource{
    func previewViewVideoThumbOverlay(_ view: TDMediaPreviewView) -> TDConfigView? {
        return self.dataSource?.previewControllerVideoThumbOverlay(self)
    }

    func previewViewSelectedThumbnailView(_ view: TDMediaPreviewView)-> TDConfigView?{
        return self.dataSource?.previewControllerSelectedThumbnailView(self)
    }
    
    func previewViewThumbnailAddView(_ view: TDMediaPreviewView)-> TDConfigView?{
         return self.dataSource?.previewControllerThumbnailAddView(self)
    }
    func previewViewHideCaptionView(_ view: TDMediaPreviewView)-> Bool?{
        return self.dataSource?.previewControllerHideCaptionView(self)
    }
}
