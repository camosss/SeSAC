//
//  Date+Extension.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import Foundation

extension String {
    func toDate(stringValue: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: stringValue)
    }
}

extension Date {
    func toString(dateValue: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy/MM/dd a hh:mm"
        return dateFormatter.string(from: dateValue)
    }
}
