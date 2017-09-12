//
//  TDMediaPicker+Album.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 10/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

// MARK: - AlbumList Controller Delegate

extension TDMediaPicker: TDAlbumListViewControllerDelegate{
   
    
    
    func albumControllerDidTapCancel(_ controller:TDAlbumListViewController){
        resetPicker()
        cleanupScreen(.All)
        self.delegate?.mediaPickerDidCancel(self)
    }
    
    func albumControllerDidTapDone(_ controller:TDAlbumListViewController){
        if serviceManager.getSelectedMedia().count == 0{
            // Display alert to select Any Media First. Or enable done button
            return
        }
        setupScreen(.Preview)
        navVC.pushViewController(previewVC!, animated: true)
    }
    
    func albumController(_ controller:TDAlbumListViewController, didSelectAlbum album:TDAlbum, animation:Bool){
        setupScreen(.Media)
        mediaListVC?.setupSelectedAlbum(album)
        navVC.pushViewController(mediaListVC!, animated: animation)
    }
}

extension TDMediaPicker: TDAlbumListViewControllerDataSource{
    
    func albumController(_ controller: TDAlbumListViewController, selectedAlbumAtInitialLoad albums: [TDAlbum]) -> TDAlbum? {
        return getSelectedAlbumAtInitialLoad(albums: albums)
    }
    
    func albumController(_ picker: TDAlbumListViewController, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return getAlbumText(album: album, mediaCount: mediaCount)!
    }

}
