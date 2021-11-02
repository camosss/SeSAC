//
//  LocalizableStrings.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import Foundation

enum LocalizableStrings: String {
    case home
    case search
    case calendar
    case setting
    case diary
    
    var localized: String {
        return self.rawValue.localized() // default - Localizable.strings
    }
    
    var localizedSetting: String {
        return self.rawValue.localized(tableName: "Setting") // Setting.strings
    }
}
