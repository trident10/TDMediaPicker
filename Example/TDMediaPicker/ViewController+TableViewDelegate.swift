//
//  ViewController+TableViewDelegate.swift
//  TDMediaPicker
//
//  Created by Abhimanu Jindal on 04/09/17.
//  Copyright © 2017 abhimanyujindal10. All rights reserved.
//


import UIKit

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTheme = themes[indexPath.row]
        present(mediaPicker!, animated: true, completion: nil)
    }
}
