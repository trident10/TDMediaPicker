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
    
    var mediaPicker: TDMediaPicker?
    @IBOutlet var tableView: UITableView!
    
    enum ThemeType: String {
        case theme1 = "Theme 1"
        case theme2 = "Theme 2"
        case theme3 = "Theme 3"
        case theme4 = "Theme 4"
        case theme5 = "Theme 5"
        case theme6 = "Theme 6"
        case theme7 = "Theme 7"
    }
    
    var themes: [ThemeType] = [.theme1, .theme2, .theme3, .theme4, .theme5, .theme6, .theme7]
    var selectedTheme: ThemeType = .theme1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMediaPicker()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.reloadData()
    }
    
    func setupMediaPicker(){
        mediaPicker = TDMediaPicker()
        mediaPicker?.delegate = self
        mediaPicker?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController{
    
    func displayAlert(title: String){
        let alertController = UIAlertController.init(title: "Message", message: title, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
