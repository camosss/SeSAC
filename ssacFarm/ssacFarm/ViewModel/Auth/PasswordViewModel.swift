//
//  PasswordViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/17.
//

import UIKit

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
