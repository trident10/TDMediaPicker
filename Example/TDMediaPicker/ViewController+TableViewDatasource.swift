//
//  ViewController+TableView.swift
//  TDMediaPicker
//
//  Created by Yapapp on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "themeCell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "themeCell")
        }
        cell?.textLabel?.text = themes[indexPath.row].rawValue
        return cell!
    }
}
