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
    case invaildToken
    case noData
    case failed
}

class APIService {
    
    // MARK: - Auth
    
    /// 회원가입
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.auth_register.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 로그인
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.auth_login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 비밀번호 변경
    static func password(token: String, currentPassword: String , newPassword: String , confirmNewPassword: String, completion: @escaping (UserElement?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.auth_password.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: - Post
    
    /// 조회
    static func postInquire(token: String, completion: @escaping (Posts?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.post_inquire.url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 작성
    static func postWrite(token: String, text: String, completion: @escaping (Post?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.post_write.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 수정
    static func postEdit(id: Int, token: String, text: String, completion: @escaping (Post?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.post_edit(id: id).url)
        request.httpMethod = Method.PUT.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 삭제
    static func postDelete(id: Int, token: String, completion: @escaping (Post?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.post_delete(id: id).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: - Comment
    
    /// 조회
    static func commentInquire(token: String, postId: Int, completion: @escaping (Comments?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.comment_inquire(postId: postId).url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 작성
    static func commentWrite(token: String, postId: Int, comment: String, completion: @escaping (CommentElement?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.comment_write.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 수정
    static func commentEdit(token: String, id: Int, postId: Int, comment: String, completion: @escaping (CommentElement?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.comment_edit(id: id).url)
        request.httpMethod = Method.PUT.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    /// 삭제
    static func commentDelete(id: Int, token: String, completion: @escaping (CommentElement?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.comment_delete(id: id).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
}

