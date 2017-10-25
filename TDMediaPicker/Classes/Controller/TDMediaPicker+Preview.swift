//
//  TDMediaPicker+Preview.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 10/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

// MARK: - Preview Controller Delegate

extension TDMediaPicker: TDMediaPreviewViewControllerDelegate{
    
    func previewControllerDidTapClose(_ controller: TDMediaPreviewViewController){
        cleanupScreen(.Preview)
        navVC.popViewController(animated: true)
    }
    
    func previewControllerDidTapAddOption(_ controller: TDMediaPreviewViewController){
        cleanupScreen(.All)
        setupScreen(.Album)
        navVC.setViewControllers([albumListVC!], animated: true)
    }
    
    func previewControllerDidTapDone(_ controller: TDMediaPreviewViewController){
        let media = serviceManager.getSelectedMedia()
        self.delegate?.mediaPicker(self, didSelectMedia: media)
    }
}

extension TDMediaPicker: TDMediaPreviewControllerDataSource{
    func previewControllerVideoThumbOverlay(_ controller: TDMediaPreviewViewController) -> TDConfigView? {
        return getMediaPickerVideoThumbOverlay(self)
    }

    func previewControllerSelectedThumbnailView(_ controller: TDMediaPreviewViewController)-> TDConfigView?{
        return getMediaPickerPreviewSelectedThumbnailView(self)
    }
    
    func previewControllerThumbnailAddView(_ controller: TDMediaPreviewViewController)-> TDConfigView?{
        return getMediaPickerPreviewAddThumbnailView(self)
    }
    
    func previewControllerHideCaptionView(_ controller: TDMediaPreviewViewController)-> Bool?{
        return getMediaPickerPreviewHideCaptionView(self)
    }
}
