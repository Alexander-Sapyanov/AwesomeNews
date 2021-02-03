//
//  NewsFeed.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//

import Foundation
struct NewsFeed: Codable {
    var status: String
    var totalResult: Int?
    var articles: [Articles]?
}


struct Articles: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
