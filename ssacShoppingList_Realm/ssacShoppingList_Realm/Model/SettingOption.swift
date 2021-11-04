//
//  SettingOption.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/04.
//

import Foundation

enum SettingOption: Int, CaseIterable {
    case backup
    case restore
    
    var description: String {
        switch self {
        case .backup: return "백업하기"
        case .restore: return "복구하기"
        }
    }
}
