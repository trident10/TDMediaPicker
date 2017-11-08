//
//  TDMediaPreviewView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPreviewViewDataSource: class {
    func previewViewSelectedThumbnailView(_ view: TDMediaPreviewView)-> TDViewConfig?
    func previewViewThumbnailAddView(_ view: TDMediaPreviewView)-> TDViewConfig?
    func previewViewHideCaptionView(_ view: TDMediaPreviewView)-> Bool?
    func previewViewVideoThumbOverlay(_ view: TDMediaPreviewView) -> TDViewConfig?
}

protocol TDMediaPreviewViewDelegate: class {
    func previewView(_ view: TDMediaPreviewView, didUpdateOperation type: TDMediaPreviewViewModel.OperationType, media: TDPreviewViewModel?)
}

class TDMediaPreviewView: UIView, TDMediaPreviewMainViewDelegate, TDMediaPreviewThumbViewDelegate{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewViewDelegate?
    weak var dataSource: TDMediaPreviewViewDataSource?
    
    private var currentSelectedIndex: Int = -1
    private var currentMedia: TDMediaPreviewViewModel?
    private var isSinglePhoto = false
    
    @IBOutlet var previewView: TDMediaPreviewMainView!
    @IBOutlet var bottomView: TDMediaPreviewThumbView!
    @IBOutlet var navigationBar: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
        bottomView.delegate = self
        bottomView.dataSource = self
        bottomView.setupView()
        
        previewView.delegate = self
        previewView.dataSource = self
        previewView.setupView()
    }
    
    // MARK: - Public Method(s)
    
    func reload(media: TDMediaPreviewViewModel, shouldDisplayAddMoreOption: Bool, shouldDisplayBottomBar: Bool){
        
        bottomView.reload(media: media, shouldDisplayAddMoreOption: shouldDisplayAddMoreOption)
        previewView.reload(media: media)
        
        currentSelectedIndex = bottomView.getCurrentSelectedIndex()
        currentMedia = media
        if !shouldDisplayBottomBar{
            isSinglePhoto = true
            bottomView.heightPortraitConstraint.constant = 0
            bottomView.heightLandscapeConstraint.constant = 0
            previewView.bottomSpace = 0
            deleteButton.isHidden = true
            self.layoutIfNeeded()
        }
    }
    
    func purgeData(){
        previewView.purgeData()
        bottomView.purgeData()
        currentSelectedIndex = -1
    }
    
    func setupNavigationTheme(_ color: UIColor){
        navigationBar.backgroundColor = color
    }
    
    func setupBackButton(_ config: TDButtonConfig){
        TDMediaUtil.setupButton(backButton, buttonConfig: config)
    }
    
    func setupNextButton(_ config: TDButtonConfig){
        TDMediaUtil.setupButton(doneButton, buttonConfig: config)
    }
    
    func setupDeleteButton(_ config: TDButtonConfig){
        TDMediaUtil.setupButton(deleteButton, buttonConfig: config)
    }
    
    // MARK: - Action Method(s)
    
    @IBAction func closedTapped(sender: UIButton){
        if isSinglePhoto{
            let media = currentMedia?.previewMedia[currentSelectedIndex]
            self.delegate?.previewView(self, didUpdateOperation: .delete, media: media!)
            return
        }
        self.delegate?.previewView(self, didUpdateOperation: .close, media: nil)
    }
    
    @IBAction func doneTapped(sender: UIButton){
        self.delegate?.previewView(self, didUpdateOperation: .done, media: nil)
    }
    
    @IBAction func deleteTapped(sender: UIButton){
        let media = currentMedia?.previewMedia[currentSelectedIndex]
        self.delegate?.previewView(self, didUpdateOperation: .delete, media: media!)
    }
    @IBAction func tapOnCollectionView(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    // MARK: - Main Preview View Delegate Method(s)
    
    func previewMainView(_ view: TDMediaPreviewMainView, didDisplayViewAtIndex index: Int) {
        currentSelectedIndex = index
        bottomView.reload(toIndex: index)
    }
    func previewMainView(_ view: TDMediaPreviewMainView, didRequestUpdateMedia media: TDPreviewViewModel) {
        self.delegate?.previewView(self, didUpdateOperation: .edit, media: media)
    }
    // MARK: - Thumb Preview View Delegate Method(s)
    
    func previewThumbView(_ view: TDMediaPreviewThumbView, didTapMediaToIndex index: Int) {
        currentSelectedIndex = index
        previewView.reload(toIndex: index)
    }
    
    func previewThumbViewDidTapAddOption(_ view: TDMediaPreviewThumbView) {
        self.delegate?.previewView(self, didUpdateOperation: .addMore, media: nil)
    }
    
}
extension TDMediaPreviewView: TDMediaPreviewThumbViewDataSource{
    func previewThumbViewVideoThumbOverlay(_ view: TDMediaPreviewThumbView) -> TDConfigView? {
        return self.dataSource?.previewViewVideoThumbOverlay(self)
    }

    func previewThumbViewSelectedThumbnailView(_ view: TDMediaPreviewThumbView)-> TDConfigView?{
        return self.dataSource?.previewViewSelectedThumbnailView(self)
    }
    
    func previewThumbViewThumbnailAddView(_ view: TDMediaPreviewThumbView)-> TDConfigView?{
        return self.dataSource?.previewViewThumbnailAddView(self)
    }
}
extension TDMediaPreviewView: TDMediaPreviewMainViewDataSource{
    func previewMainViewHideCaptionView(_ view: TDMediaPreviewMainView)-> Bool?{
        return self.dataSource?.previewViewHideCaptionView(self)
    }
}

