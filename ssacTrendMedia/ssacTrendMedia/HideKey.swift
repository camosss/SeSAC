//
//  HideKey.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/28.
//

import Foundation

extension Bundle {
    var apiKey: String {
        get {
            // 생성한 .plist 파일 경로
            guard let filePath = self.path(forResource: "keyInfo", ofType: "plist") else { fatalError("Couldn't find file 'KeyList.plist'.")}
            
            // plist를 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 값 찾기
            guard let value = plist?.object(forKey: "API_KEY") as? String else { fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.") }
            
            return value
        }
    }
}
