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
        mediaPicker.delegate = self
        mediaPicker.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.reloadData()
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

