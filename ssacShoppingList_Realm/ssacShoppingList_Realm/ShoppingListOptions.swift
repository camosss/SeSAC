//
//  ShoppingListOptions.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/03.
//

import Foundation

enum ShoppingListOptions: Int, CaseIterable {
    case toDoBasis
    case favorites
    case title
    
    var description: String {
        switch self {
        case .toDoBasis: return "기본"
        case .favorites: return "즐겨찾기"
        case .title: return "제목"
        }
    }
}
