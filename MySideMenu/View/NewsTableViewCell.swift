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
        
        // Image View
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
     
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.clipsToBounds = true
 
        // Text label
        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView!.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView!.heightAnchor.constraint(equalToConstant: 150),
            textLabel!.centerYAnchor.constraint(equalTo: imageView!.centerYAnchor),
            textLabel!.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: 10),
            textLabel!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel!.heightAnchor.constraint(equalTo: imageView!.heightAnchor, constant: 9/3),
            textLabel!.widthAnchor.constraint(equalToConstant: 150)
        ])

        self.textLabel?.numberOfLines = 5
        self.textLabel?.adjustsFontForContentSizeCategory = true
        self.textLabel?.backgroundColor = .clear
        self.textLabel?.font = UIFont(name: "Helvetica", size: 15)
        self.textLabel?.layer.cornerRadius = 10
    
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.backgroundColor = .white
    }
}
