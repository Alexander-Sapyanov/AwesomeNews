//
//  SafariDelegate.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 17.03.2021.
//

import Foundation
import SafariServices
// SafariDelegate
extension ViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
