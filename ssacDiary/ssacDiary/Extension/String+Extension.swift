//
//  String+Extension.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import Foundation

extension String {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
    
    func localized(tableName: String = "Localizable") -> String { // default - Localizable
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
}
