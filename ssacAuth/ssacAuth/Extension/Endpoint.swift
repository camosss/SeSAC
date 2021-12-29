//
//  Endpoint.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/29.
//

import Foundation

// MARK: - Method

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// MARK: - URL

enum Endpoint {
    case signup
    case login
    case board
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup: return .makeEndpoint("auth/local/register")
        case .login: return .makeEndpoint("auth/local")
        case .board: return .makeEndpoint("boards")
        case .boardDetail(id: let id): return .makeEndpoint("board/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

// MARK: - URLSession

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else { completion(nil, .failed); return }
                guard let data = data else { completion(nil, .noData); return }
                guard let response = response as? HTTPURLResponse else { completion(nil, .invaildResponse); return }
                guard response.statusCode == 200 else { completion(nil, .failed); return }
                
                do {
                    let decoder = JSONDecoder()
                    let modelData = try decoder.decode(T.self, from: data)
                    completion(modelData, nil)
                } catch {
                    completion(nil, .invaildData)
                }
            }
        }
    }
}
