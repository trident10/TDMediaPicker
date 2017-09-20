//
//  TDMediaPicker+Media.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 10/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit
// MARK: - Media Controller Delegate

extension TDMediaPicker: TDMediaListViewControllerDelegate{
    
    // MARK: - Media Controller Delegate Method(s)
    
    func mediaControllerDidTapDone(_ view: TDMediaListViewController){
        setupScreen(.Preview)
        navVC.pushViewController(previewVC!, animated: true)
    }
    
    func mediaControllerDidTapCancel(_ view: TDMediaListViewController) {
        cleanupScreen(.Media)
        navVC.popViewController(animated: true)
    }
    
}
extension TDMediaPicker: TDMediaListViewControllerDataSource{
    func mediaControllerVideoThumbOverlay(_ view: TDMediaListViewController) -> TDConfigView? {
        return getMediaPickerVideoThumbOverlay(self)
    }

    func mediaController(_ view: TDMediaListViewController, countForMedia mediaCount: Int)-> TDConfigView?{
        return getMediaHighlightedView(self, countForMedia: mediaCount)
    }
}
