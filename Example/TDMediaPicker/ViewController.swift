//
//  ViewController.swift
//  TDMediaPicker
//
//  Created by abhimanyujindal10 on 07/19/2017.
//  Copyright (c) 2017 abhimanyujindal10. All rights reserved.
//

import UIKit
import TDMediaPicker

class ViewController: UIViewController {
    
    var mediaPicker = TDMediaPicker()

    override func viewDidLoad() {
        mediaPicker.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPickerButtonTapped(sender: UIButton){
        present(mediaPicker, animated: true, completion: nil)
    }

}

extension ViewController: TDMediaPickerDelegate{
    func mediaPicker(_ picker: TDMediaPicker, didSelectMedia media: [TDMedia]) {
        mediaPicker.dismiss(animated: true) {
            self.displayAlert(title: "\(media.count) media selected")
        }
    }
    
    func mediaPickerDidCancel(_ picker: TDMediaPicker) {
        print("Media Picker Cancelled")
        mediaPicker.dismiss(animated: true){
            self.displayAlert(title: "Media Selection Cancelled")

        }
    }
}

extension ViewController{
    
    fileprivate func displayAlert(title: String){
        let alertController = UIAlertController.init(title: "Message", message: title, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

