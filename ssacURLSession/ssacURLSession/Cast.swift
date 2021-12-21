//
//  Cast.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import Foundation

struct Cast: Codable {
    let peopleListResult: PeopleListResult
}

struct PeopleListResult: Codable {
    let totCnt: Int
    let peopleList: [PeopleList]
    let source: String
}

struct PeopleList: Codable {
    let peopleCD, peopleNm: String
    let peopleNmEn: PeopleNmEn
    let repRoleNm, filmoNames: String
    
    enum CodingKeys: String, CodingKey {
        case peopleCD = "peopleCd"
        case peopleNm, peopleNmEn, repRoleNm, filmoNames
    }
}

enum PeopleNmEn: String, Codable {
    case choiWooyoung = "choi wooyoung"
    case empty = ""
    case parkJiHyun = "PARK JI HYUN"
}
