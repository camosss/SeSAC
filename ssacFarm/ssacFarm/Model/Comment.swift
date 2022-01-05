//
//  Comment.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import Foundation

typealias Comments = [CommentElement]

struct CommentElement: Codable {
    let id: Int
    let comment: String
    let user: UserModel
    let post: PostElement
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct PostElement: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
