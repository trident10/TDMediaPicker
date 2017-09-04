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
        cleanupScreen(.All)
        resetPicker()
    }
    
    
}
