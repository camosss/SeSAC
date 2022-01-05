//
//  Post.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/04.
//

import Foundation

typealias Posts = [Post]

struct Post: Codable {
    let id: Int
    let text: String
    let user: UserModel
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}
