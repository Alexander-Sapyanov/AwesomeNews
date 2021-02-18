//
//  Networking.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 04.02.2021.
//

import Foundation

class Networking {
    private var articles: NewsFeed?
    
    func request(urlString: String, completion: @escaping (Result<NewsFeed, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { ( data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let news = try JSONDecoder().decode(NewsFeed.self, from: data)
                    completion(.success(news))
                }
                catch let jsonError{
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
