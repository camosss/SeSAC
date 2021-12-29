//
//  SignInViewModel.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
//

import Foundation

class SignInViewModel {
    
    var username: Observable<String> = Observable("유저네임")
    var password: Observable<String> = Observable("비밀번호")
    
    func postUserLogin(completion: @escaping (User?, APIError?) -> Void) {
        
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let userData = userData else { return }

            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            
            completion(userData, error)
        }
        
    }
}
