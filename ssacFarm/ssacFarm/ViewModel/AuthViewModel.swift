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
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemGreen : .systemGreen.withAlphaComponent(0.5)
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
}

