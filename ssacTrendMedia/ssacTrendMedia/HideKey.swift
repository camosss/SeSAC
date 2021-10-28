//
//  HideKey.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/28.
//

import Foundation

extension Bundle {
    var kobisApiKey: String {
        get {
            guard let filePath = self.path(forResource: "keyInfo", ofType: "plist") else { fatalError("Couldn't find file 'KeyList.plist'.")}
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "kobis_API_KEY") as? String else { fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.") }
            return value
        }
    }
    
    var tmDBApiKey: String {
        get {
            guard let filePath = self.path(forResource: "keyInfo", ofType: "plist") else { fatalError("Couldn't find file 'KeyList.plist'.")}
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "tmDB_API_KEY") as? String else { fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.") }
            return value
        }
    }
}
