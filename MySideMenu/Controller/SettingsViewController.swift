//
//  SettingsViewController.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        button.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(push), for: .touchDown)
        view.addSubview(button)
        
    }
    
    @objc func push() {
        let vc = ViewController()
        
        vc.view.backgroundColor = .red
    }
}
