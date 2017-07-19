//
//  TDMediaPicker+Permission.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 10/07/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import Foundation

extension TDMediaPicker: TDMediaPermissionViewControllerDelegate{
    // MARK: - Permission Controller Delegate
    
    func permissionControllerDidFinish(_ controller: TDMediaPermissionViewController) {
        DispatchQueue.main.async {
            self.cleanupScreen(.Permission)
            self.showPickerScreen()
        }
    }
}
