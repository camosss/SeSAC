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
        return date
    }
    
    static var customTextFormat: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyy년 MM월 dd일"
        date.locale = Locale(identifier: "ko")
        return date
    }
}
