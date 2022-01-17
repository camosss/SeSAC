//
//  SignInViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/17.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

struct SignInViewModel {
    let tk = TokenUtils()
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemGreen : .systemGreen.withAlphaComponent(0.5)
    }
    
    func postUserLoginData(email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        APIService.login(identifier: email, password: password) { user, error in
            if let error = error {
                completion(nil, error)
            }
            guard let user = user else { return }
            self.tk.create("\(Endpoint.auth_register.url)", account: "token", value: user.jwt)
            self.tk.create("\(Endpoint.auth_register.url)", account: "id", value:"\(user.user.id)")
            completion(user, error)
        }
    }
}
