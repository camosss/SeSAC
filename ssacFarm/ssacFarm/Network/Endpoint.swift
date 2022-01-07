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
    case post_detail_inquire(id: Int)
    case post_inquire
    case post_write
    case post_edit(id: Int)
    case post_delete(id: Int)
    case comment_inquire(postId: Int)
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
        case .post_detail_inquire(id: let id): return .makeEndpoint("posts/\(id)")
        case .post_inquire: return .makeEndpoint("posts?_start=0&_limit=100&_sort=created_at:desc")
        case .post_write: return .makeEndpoint("posts")
        case .post_edit(id: let id): return .makeEndpoint("posts/\(id)")
        case .post_delete(id: let id): return .makeEndpoint("posts/\(id)")
        case .comment_inquire(postId: let postId): return .makeEndpoint("comments?post=\(postId)")
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

