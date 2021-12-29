//
//  RegisterViewModel.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/29.
//

import Foundation

class RegisterViewModel {
    
    var username: Observable<String> = Observable("유저네임")
    var email: Observable<String> = Observable("이메일")
    var password: Observable<String> = Observable("비밀번호")

    func postUserRegister(completion: @escaping (User?, APIError?) -> Void) {
        
        APIService.register(username: username.value, email: email.value, password: password.value) { userData, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let userData = userData else { return }
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")

            completion(userData, nil)
        }
        
    }
}
