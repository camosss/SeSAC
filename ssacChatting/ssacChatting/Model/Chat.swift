//
//  Chat.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/14.
//

import Foundation

struct Chat: Codable {
    let text, userID, name, username: String
    let id, createdAt, updatedAt: String
    let v: Int
    let chatID: String

    enum CodingKeys: String, CodingKey {
        case text
        case userID = "userId"
        case name, username
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
        case chatID = "id"
    }
}
