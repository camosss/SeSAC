//
//  RealmBoxOffice.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/11/07.
//

import Foundation
import RealmSwift

class RealmBoxOffice: Object {
    @Persisted var date: String
    @Persisted var boxOfficeList: String

    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(date: String, boxOffeceList: List<String>) {
        self.init()
        self.date = date
        self.boxOfficeList = boxOfficeList
    }
}
