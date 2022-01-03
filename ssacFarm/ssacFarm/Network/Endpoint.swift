//
//  Endpoint.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/03.
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
    case auth_register
    case auth_login
    case auth_password
    case post_inquire
    case post_write
    case post_edit(id: Int)
    case post_delete(id: Int)
    case comment_inquire
    case comment_write
    case comment_edit(id: Int)
    case comment_delete(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .auth_register: return .makeEndpoint("auth/local/register")
        case .auth_login: return .makeEndpoint("auth/local")
        case .auth_password: return .makeEndpoint("custom/change-password")
        case .post_inquire: return .makeEndpoint("posts")
        case .post_write: return .makeEndpoint("posts")
        case .post_edit(id: let id): return .makeEndpoint("posts/\(id)")
        case .post_delete(id: let id): return .makeEndpoint("posts/\(id)")
        case .comment_inquire: return .makeEndpoint("comments")
        case .comment_write: return .makeEndpoint("comments")
        case .comment_edit(id: let id): return .makeEndpoint("comments/\(id)")
        case .comment_delete(id: let id): return .makeEndpoint("comments/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
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
