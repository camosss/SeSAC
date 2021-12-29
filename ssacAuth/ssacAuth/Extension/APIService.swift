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
    
    // MARK: - Auth
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.signup.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: - Lotto
    
    static func lotto(_ number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else { completion(nil, .failed); return }
                guard let data = data else { completion(nil, .noData); return }
                guard let response = response as? HTTPURLResponse else { completion(nil, .invaildResponse); return }
                guard response.statusCode == 200 else { completion(nil, .failed); return }

                do {
                    let decoder = JSONDecoder()
                    let lottoData = try decoder.decode(Lotto.self, from: data)
                    completion(lottoData, nil)
                } catch {
                    completion(nil, .invaildData)
                }
            }

        }.resume()
    }
    
    // MARK: - Person
    
    static func person(_ text: String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        let key = "41228218ab5d729f608f18f42b7cf848"
        let language = "ko-KR"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else { completion(nil, .failed); return }
                guard let data = data else { completion(nil, .noData); return }
                guard let response = response as? HTTPURLResponse else { completion(nil, .invaildResponse); return }
                guard response.statusCode == 200 else { completion(nil, .failed); return }
                
                do {
                    let decoder = JSONDecoder()
                    let personData = try decoder.decode(Person.self, from: data)
                    completion(personData, nil)
                } catch {
                    completion(nil, .invaildData)
                }
            }
            
        }.resume()
    }
}
