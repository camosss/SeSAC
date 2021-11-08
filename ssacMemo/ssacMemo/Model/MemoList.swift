//
//  MemoList.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import Foundation
import RealmSwift

class MemoList: Object {
    @Persisted var title: String
    @Persisted var subTitle: String
    @Persisted var date = Date()
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, subTitle: String, date: Date) {
        self.init()
        self.title = title
        self.subTitle = subTitle
        self.date = date
    }
}
