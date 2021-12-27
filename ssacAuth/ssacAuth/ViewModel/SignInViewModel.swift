//
//  SignInViewModel.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
//

import Foundation

class SignInViewModel {
    
    var username: Observable<String> = Observable("유저네임")
    var password: Observable<String> = Observable("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            guard let userData = userData else { return }

            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
        
    }
}
