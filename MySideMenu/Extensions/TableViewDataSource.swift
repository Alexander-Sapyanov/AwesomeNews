//
//  TableViewDataSource.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 17.03.2021.
//

import UIKit

// TableView Data source
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifire, for: indexPath) as! NewsTableViewCell
        
        let currentUrl = datas[indexPath.row].urlToImage
        
        guard let url = URL(string: currentUrl ?? "https://picsum.photos/200") else {return cell}
        cell.imageView?.sd_setImage(with: url,placeholderImage: UIImage(named: "1"),options: [.continueInBackground,.progressiveLoad],completed: nil)
        cell.textLabel?.text = datas[indexPath.row].title
        cell.detailTextLabel?.text = datas[indexPath.row].publishedAt
        cell.imageView?.clipsToBounds = true
        cell.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
