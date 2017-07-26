//
//  TDMediaPreviewView.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 28/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

protocol TDMediaPreviewViewDelegate: class {
    func previewViewDidTapClose(_ view: TDMediaPreviewView)
    func previewViewDidTapAddMore(_ view: TDMediaPreviewView)
    func previewViewDidTapDone(_ view: TDMediaPreviewView)
}

class TDMediaPreviewView: UIView, TDMediaPreviewMainViewDelegate, TDMediaPreviewThumbViewDelegate{
    
    // MARK: - Variable(s)
    
    weak var delegate: TDMediaPreviewViewDelegate?
    
    @IBOutlet var previewView: TDMediaPreviewMainView!
    @IBOutlet var bottomView: TDMediaPreviewThumbView!
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        
        bottomView.delegate = self
        bottomView.setupView()
        
        previewView.delegate = self
        previewView.setupView()
    }
    
    // MARK: - Public Method(s)
    
    func reload(media: [TDPreviewViewModel], shouldDisplayAddMoreOption: Bool){
        bottomView.reload(media: media, shouldDisplayAddMoreOption: shouldDisplayAddMoreOption)
        previewView.reload(media: media)
    }
    
    func purgeData(){
        previewView.purgeData()
        bottomView.purgeData()
    }
    
    // MARK: - Action Method(s)
    
    @IBAction func closedTapped(sender: UIButton){
        self.delegate?.previewViewDidTapClose(self)
    }
    
    @IBAction func doneTapped(sender: UIButton){
        self.delegate?.previewViewDidTapDone(self)
    }
    
    // MARK: - Main Preview View Delegate Method(s)
    
    func previewMainView(_ view: TDMediaPreviewMainView, didDisplayViewAtIndex index: Int) {
        bottomView.reload(toIndex: index)
    }
    
    // MARK: - Thumb Preview View Delegate Method(s)
    
    func previewThumbView(_ view: TDMediaPreviewThumbView, didTapMediaToIndex index: Int) {
        previewView.reload(toIndex: index)
    }
    
    func previewThumbViewDidTapAddOption(_ view: TDMediaPreviewThumbView) {
        self.delegate?.previewViewDidTapAddMore(self)
    }
    
}

