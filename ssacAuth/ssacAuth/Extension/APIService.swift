//
//  APIService.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
//

import Foundation

enum APIError: Error {
    case invaildResponse
    case invaildData
    case noData
    case failed
}

class APIService {
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/auth/local")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else { completion(nil, .failed); return }
            guard let data = data else { completion(nil, .noData); return }
            guard let response = response as? HTTPURLResponse else { completion(nil, .invaildResponse); return }
            guard response.statusCode == 200 else { completion(nil, .failed); return }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invaildData)
            }
            
        }.resume()
    }
}
