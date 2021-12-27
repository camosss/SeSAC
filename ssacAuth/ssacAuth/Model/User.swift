//
//  User.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
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
