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
    let viewModel = SignInViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        bindingViewModel()
    }
    
    // MARK: - Helper
    
    func bindingViewModel() {
        viewModel.username.bind { text in
            self.signInView.usernameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.signInView.passwordTextField.text = text
        }
    }
    
    func setAddTarget() {
        signInView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)

        signInView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }

    // MARK: - Action
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
}

