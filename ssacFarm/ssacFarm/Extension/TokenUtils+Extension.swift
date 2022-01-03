//
//  TokenUtils+Extension.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/04.
//

import Foundation
import Security
 
class TokenUtils {
    
    // Create
    // service 파라미터는 url주소를 의미
    func create(_ url: String, account: String, value: String) {
        
        // 1. query작성
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService: url,
            kSecAttrAccount: account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        // allowLossyConversion은 인코딩 과정에서 손실이 되는 것을 허용할 것인지 설정
        
        // 2. Delete
        // Key Chain은 Key값에 중복이 생기면 저장할 수 없기때문에 먼저 Delete
        SecItemDelete(keyChainQuery)
        
        // 3. Create
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "failed to saving Token")
    }
    
    // Delete
    func delete(_ url: String, account: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: url,
            kSecAttrAccount: account
        ]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
    
    // 키 체인에 저장된 값을 읽어옴
    func load(_ url: String, account: String) -> String? {
        // 키 체인 쿼리
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: url,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        // 키 체인에 저장된 값을 읽어옴
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        // 처리 결과가 성공이면 Data 타입으로 변환 - 다시 String 타입으로 변환
        if (status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else { // 실패면 nil 반환
            print("Nothing was retrieved from the ketchain. Status code \(status)")
            return nil
        }
    }
    
    func update(_ url: String, value: String) {
        
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: url
        ]
        
        let updateFields: NSDictionary = [
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        let status = SecItemUpdate(query, updateFields)
        print("Operation finished with status: \(status)")
    }
}
 
