//
//  TDMediaUtil+Bundle.swift
//  Pods
//
//  Created by Abhimanu Jindal on 19/07/17.
//
//

import Foundation

extension (TDMediaUtil){
    
    static func xibBundle() -> Bundle{
        
        let frameWorkBundle = Bundle(for: TDMediaUtil.self)
        let bundleURL = frameWorkBundle.url(forResource: "TDMediaPickerXIB", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
    
    static func pngBundle() -> Bundle{
        
        let frameWorkBundle = Bundle(for: TDMediaUtil.self)
        let bundleURL = frameWorkBundle.url(forResource: "TDMediaPickerPNG", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
    
    static func pdfBundle() -> Bundle{
        
        let frameWorkBundle = Bundle(for: TDMediaUtil.self)
        let bundleURL = frameWorkBundle.url(forResource: "TDMediaPickerPDF", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
    
    
    /*
     
     let frameworkBundle = Bundle(for: TDMediaPreviewViewController.self)
     if let bundleURL = podBundle.URLForResource("MyCustomPod", withExtension: "bundle") {
     
     if let bundle = NSBundle(URL: bundleURL) {
     
     let cellNib = UINib(nibName: classNameToLoad, bundle: bundle)
     self.collectionView!.registerNib(cellNib, forCellWithReuseIdentifier: classNameToLoad)
     
     }else {
     
     assertionFailure("Could not load the bundle")
     
     }
     
     }else {
     
     assertionFailure("Could not create a path to the bundle")
     
     */
}
