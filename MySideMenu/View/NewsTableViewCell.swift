//
//  NewsTableViewCell.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifire = "Cell"
    
    override func layoutSubviews() {
          super.layoutSubviews()
          // Customize imageView like you need
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.centerYAnchor.constraint(equalTo: centerYAnchor ).isActive = true
        self.imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        self.imageView?.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.imageView?.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.clipsToBounds = true
          // Costomize other elements
        
        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel?.centerYAnchor.constraint(equalTo: imageView!.centerYAnchor).isActive = true
        self.textLabel?.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: 10).isActive = true
        self.textLabel?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.textLabel?.heightAnchor.constraint(equalTo: imageView!.heightAnchor, constant: 9/3).isActive = true
        self.textLabel?.widthAnchor.constraint(equalToConstant: 150).isActive = true
     
        
        self.textLabel?.numberOfLines = 5
        self.textLabel?.adjustsFontForContentSizeCategory = true
        self.textLabel?.backgroundColor = .clear
        self.textLabel?.font = UIFont(name: "Helvetica", size: 15)
        self.textLabel?.layer.cornerRadius = 10
    
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.backgroundColor = .white
        
    
}
}
