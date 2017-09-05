//
//  TDMediaPreviewView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPreviewViewDelegate: class {
    func previewView(_ view: TDMediaPreviewView, didUpdateOperation type: TDMediaPreviewViewModel.OperationType, media: TDPreviewViewModel?)
}

class TDMediaPreviewView: UIView, TDMediaPreviewMainViewDelegate, TDMediaPreviewThumbViewDelegate{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewViewDelegate?
    
    private var currentSelectedIndex: Int = -1
    private var currentMedia: TDMediaPreviewViewModel?
    
    @IBOutlet var previewView: TDMediaPreviewMainView!
    @IBOutlet var bottomView: TDMediaPreviewThumbView!
    @IBOutlet var navigationBar: UIView!

    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
        bottomView.delegate = self
        bottomView.setupView()
        
        previewView.delegate = self
        previewView.setupView()
    }
    
    // MARK: - Public Method(s)
    
    func reload(media: TDMediaPreviewViewModel, shouldDisplayAddMoreOption: Bool){
        
        bottomView.reload(media: media, shouldDisplayAddMoreOption: shouldDisplayAddMoreOption)
        previewView.reload(media: media)
        
        currentSelectedIndex = bottomView.getCurrentSelectedIndex()
        currentMedia = media
    }
    
    func purgeData(){
        previewView.purgeData()
        bottomView.purgeData()
        currentSelectedIndex = -1
    }
    
    func setupNavigationTheme(_ color: UIColor){
        navigationBar.backgroundColor = color
    }
    
    // MARK: - Action Method(s)
    
    @IBAction func closedTapped(sender: UIButton){
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

