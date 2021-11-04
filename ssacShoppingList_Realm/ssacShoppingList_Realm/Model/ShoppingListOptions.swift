//
//  ShoppingListOptions.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/03.
//

import Foundation

enum ShoppingListOptions: Int, CaseIterable {
    case toDo
    case favorites
    case title
    case basic
    
    var description: String {
        switch self {
        case .toDo: return "할 일순"
        case .favorites: return "즐겨찾기순"
        case .title: return "제목순"
        case .basic: return "처음으로"
        }
    }
}
