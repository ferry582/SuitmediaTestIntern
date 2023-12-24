//
//  APIService.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import Foundation

class APIService: NSObject {
    
    func getListUsers(page: Int, completion: @escaping (UserResponse) -> ()) {
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "reqres.in"
            components.port = nil
            components.path = "/api/users"
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "10")
            ]
            return components.url
        }
        
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(UserResponse.self, from: data)
                completion(empData)
            }
            
            if let error = error {
                print(error)
            }
        }.resume()
    }
}
