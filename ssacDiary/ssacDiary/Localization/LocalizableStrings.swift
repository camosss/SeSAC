//
//  LocalizableStrings.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import Foundation

enum LocalizableStrings: String {
    case welcome_text
    case data_backup
    case data_restore
    
    var localized: String {
        return self.rawValue.localized() // default - Localizable.strings
    }
    
    var localizedSetting: String {
        return self.rawValue.localized(tableName: "Setting") // Setting.strings
    }
}
