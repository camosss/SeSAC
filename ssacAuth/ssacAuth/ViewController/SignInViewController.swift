//
//  SignInViewController.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
//

import UIKit

class SignInViewController: UIViewController {

    // MARK: - Properties
    
    let signInView = SignInView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }

    // MARK: - Action
    
    @objc func signInButtonClicked() {
        guard let username = signInView.usernameTextField.text else { return }
        guard let password = signInView.passwordTextField.text else { return }

        APIService.login(identifier: username, password: password) { userData, error in
            guard let userData = userData else { return }
            print(username, password, userData)
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "name")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
            
        }
        
    }
}

