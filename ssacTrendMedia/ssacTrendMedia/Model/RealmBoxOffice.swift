//
//  RealmBoxOffice.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/11/07.
//

import Foundation
import RealmSwift
import UIKit

//struct BoxOffice {
//  let rank: String
//  let title: String
//  let openDt: String
//}

class UserDiary: Object {
    @Persisted var diaryTitle: String
    @Persisted var content: String?
    @Persisted var createdDate = Date()
    @Persisted var registerDate = Date()
    @Persisted var favorite: Bool
    @Persisted var postImage: String?

    // PK: Int, String, UUID, ObjectId
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, content: String?, createdDate: Date, registerDate: Date, postImage: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.content = content
        self.createdDate = createdDate
        self.registerDate = registerDate
        self.favorite = false
        self.postImage = postImage
    }
}
