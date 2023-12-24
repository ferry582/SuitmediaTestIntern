//
//  APIService.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import Foundation

enum APIServiceError: Error {
    case serverError(String = "Server erro occured")
    case decodingError(String = "Error parsing server response.")
}

class APIService: NSObject {
    
    func getListUsers(page: Int) async throws -> UserResponse {
        
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
        
        let (data, response) = try await URLSession.shared.data(from: url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIServiceError.serverError()
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            let usersData = try jsonDecoder.decode(UserResponse.self, from: data)
            return usersData
        } catch{
            throw APIServiceError.decodingError()
        }
    }
}
