//
//  ShoppingList.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/03.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    @Persisted var list: String
    @Persisted var check: Bool
    @Persisted var star: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(list: String) {
        self.init()
        self.list = list
        self.check = false
        self.star = false
    }
}
