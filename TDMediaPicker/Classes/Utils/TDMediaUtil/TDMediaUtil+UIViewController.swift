//
//  TDMediaUtil+VC.swift
//  ImagePicker
//
//  Created by Abhimanu Jindal on 25/06/17.
//  Copyright © 2017 Abhimanu Jindal. All rights reserved.
//

import UIKit

extension (TDMediaUtil){
    static func addChildController(_ controller: UIViewController, toController: UIViewController) {
        toController.addChildViewController(controller)
        toController.view.addSubview(controller.view)
        controller.didMove(toParentViewController: toController)
        
        TDMediaUtil.pinEdges(sourceView: controller.view)
    }
    
    static func removeFromParentController(_ controller: UIViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
}
