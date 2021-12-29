//
//  RegisterViewController.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/29.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    let registerView = RegisterView()
    let viewModel = RegisterViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        bindingViewModel()
        setAddTarget()
    }
    
    // MARK: - Helper
    
    func bindingViewModel() {
        viewModel.username.bind { text in
            self.registerView.usernameTextField.text = text
        }
        
        viewModel.email.bind { text in
            self.registerView.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.registerView.passwordTextField.text = text
        }
    }
    
    func setAddTarget() {
        registerView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        registerView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        registerView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        registerView.registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
    }
    
    
    // MARK: - Action
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func registerButtonClicked() {
        viewModel.postUserRegister { userData, error in 
            DispatchQueue.main.async {
                if let _ = error {
                    let alert = UIAlertController(title: "회원가입 실패", message: "이미 있는 정보입니다.", preferredStyle: .alert)
                    alert.addAction(.init(title: "확인", style: .default))
                    self.present(alert, animated: true)
                }
                
                if let _ = userData {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                }
                
            }
        }
    }

}
