//
//  AuthViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/03.
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

struct PasswordViewModel {
    let tk = TokenUtils()

    var currentPassword: String?
    var newPassword: String?
    var confirmPassword: String?

    var formIsValid: Bool {
        return currentPassword?.isEmpty == false && newPassword?.isEmpty == false && confirmPassword?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemGreen : .systemGreen.withAlphaComponent(0.5)
    }
    
    func changeUserPassword(currentPassword: String , newPassword: String , confirmNewPassword: String, completion: @escaping (UserElement?, APIError?) -> Void) {
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? ""

        APIService.password(token: token, currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { user, error in
            if let error = error {
                completion(nil, error)
            }
            guard let user = user else { return }
            completion(user, error)
        }
    }
}
