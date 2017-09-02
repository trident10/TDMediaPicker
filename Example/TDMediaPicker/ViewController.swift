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
        mediaPicker.dataSource = self
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


extension ViewController: TDMediaPickerDataSource{
    
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker) -> TDConfigPermissionScreen {
        
        //1.
        //let view = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        //view.backgroundColor = .red
        //let configView = TDConfigViewCustom(view: view)
        
        //2.
        //let configView = TDConfigViewStandard(backgroundColor: .blue)
        //let permissionConfig = TDConfigPermissionScreen(standardView: configView)
        
        //3.
        let permissionConfig = TDConfigPermissionScreen()
        permissionConfig.settingButton = TDConfigButtonText.init(normalColor: .red, normalTextConfig: TDConfigText.init(text: "Settings", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        permissionConfig.cancelButton = TDConfigButtonImage.init(normalImage: UIImage.init(named: "close"), customSize: CGSize.init(width: 16, height: 16))
        
        //4. 
        
        permissionConfig.caption = TDConfigLabel.init(backgroundColor: .clear, textConfig: TDConfigText.init(text: "1. Please give access to photo library. 2. Please give access to photo library. 3. Please give access to photo library. 4. Please give access to photo library. 5. Please give access to photo library. 6. Please give access to photo library. 7. Please give access to photo library.", textColor: .black, textFont: UIFont.boldSystemFont(ofSize: 20)), textAlignment: .center, lineBreakMode: .byWordWrapping, minimumFontSize: 2.0)
            
            //TDConfigText.init(text: "Please give access to photo library", textColor: .black, textFont: UIFont.boldSystemFont(ofSize: 10))
        return permissionConfig
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

