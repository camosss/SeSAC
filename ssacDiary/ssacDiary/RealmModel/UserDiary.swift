//
//  UserDiary.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/02.
//

import Foundation
import RealmSwift

class UserDiary: Object {
    @Persisted var diaryTitle: String
    @Persisted var content: String?
    @Persisted var createdDate = Date()
    @Persisted var registerDate = Date()
    @Persisted var favorite: Bool

    // PK: Int, String, UUID, ObjectId
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, content: String?, createdDate: Date, registerDate: Date) {
        self.init()
        self.diaryTitle = diaryTitle
        self.content = content
        self.createdDate = createdDate
        self.registerDate = registerDate
        self.favorite = false
    }
}

