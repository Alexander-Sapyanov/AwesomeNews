//
//  InfoViewController.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource {
    let infoTableView = UITableView()
    let titles = ["Version: 1.0"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
       
    }
    
    func setUpTableView() {
        infoTableView.dataSource = self
        infoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(infoTableView)
        infoTableView.frame = CGRect(x: 0, y: 150, width: Int(view.bounds.size.width), height: 40)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    
}

