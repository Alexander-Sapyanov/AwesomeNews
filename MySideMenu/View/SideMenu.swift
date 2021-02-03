//
//  SideMenu.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//

import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}

class MenuController: UITableViewController {
    public var delegate: MenuControllerDelegate?
    private let menuItems: [String]
    private let color = UIColor(red: 32/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    // MARK: - Init
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
     
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        view.backgroundColor = color
    }
    // MARK: - Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.contentView.backgroundColor = color
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Relay to delegate about menu item selection
        
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
        
    }
}
