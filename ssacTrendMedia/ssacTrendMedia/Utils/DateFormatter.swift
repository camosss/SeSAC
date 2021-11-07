//
//  DateFormatter.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/11/07.
//

import Foundation

extension DateFormatter {

    static var customFormat: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyyMMdd"
        date.locale = Locale(identifier: "ko")
        return date
    }
}
