//
//  ViewController+MediaPickerDelegate.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import TDMediaPicker

extension ViewController: TDMediaPickerDelegate{
    func mediaPicker(_ picker: TDMediaPicker, didSelectMedia media: [TDMedia]) {
        mediaPicker?.dismiss(animated: true) {
            self.displayAlert(title: "\(media.count) media selected")
            self.setupMediaPicker()
        }
    }
    
    func mediaPickerDidCancel(_ picker: TDMediaPicker) {
        print("Media Picker Cancelled")
        mediaPicker?.dismiss(animated: true){
            self.displayAlert(title: "Media Selection Cancelled")
            self.setupMediaPicker()
        }
    }
}
