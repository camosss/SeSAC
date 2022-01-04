//
//  Post.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/04.
//

import Foundation

struct Posts: Codable {
    var posts: [Post]
}

struct Post: Codable {
    let id: Int
    let text: String
    let user: User
    let createdAt, updatedAt: String
//    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case comments
    }
}

//struct Comment: Codable {
//    let id: Int
//    let comment: String
//    let user, post: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, comment, user, post
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
