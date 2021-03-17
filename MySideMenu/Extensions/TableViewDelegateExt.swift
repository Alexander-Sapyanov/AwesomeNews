//
//  TableViewDelegateExt.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 17.03.2021.
//

import UIKit
import SafariServices

// TableView Delegate
extension ViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrail = datas[indexPath.row]
        let url = selectedTrail.url
        
        let safariVC = SFSafariViewController(url: URL(string: url!)!)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
    }
}
