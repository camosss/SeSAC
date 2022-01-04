//
//  User.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/03.
//

import Foundation

struct User: Codable {
    let jwt: String
    let user: UserClass
}

struct UserClass: Codable {
    let id: Int
    let username, email: String
}