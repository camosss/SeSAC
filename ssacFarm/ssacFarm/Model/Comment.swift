//
//  Comment.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
