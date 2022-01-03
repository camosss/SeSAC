//
//  APIService.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/03.
//

import Foundation

enum APIError: Error {
    case invaildResponse
    case invaildData
    case noData
    case failed
}

class APIService {
    
    // MARK: - Auth
    
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.auth_register.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.auth_login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
}
