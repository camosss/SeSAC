//
//  RegisterViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/17.
//

import UIKit

struct RegisterViewModel {
    var email: String?
    var name: String?
    var password: String?
    var repassword: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && name?.isEmpty == false && password?.isEmpty == false && repassword?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemGreen : .systemGreen.withAlphaComponent(0.5)
    }
    
    func postUserRegisterData(name: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        APIService.register(username: name, email: email, password: password) { user, error in
            if let _ = error {
                completion(nil, error)
            }
            guard let user = user else { return }
            completion(user, error)
        }
    }
}
