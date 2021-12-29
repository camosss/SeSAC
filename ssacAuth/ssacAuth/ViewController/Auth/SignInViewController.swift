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
        view.backgroundColor = .purple
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
        signInView.dontHaveAccountButton.addTarget(self, action: #selector(dontHaveAccountButtonClicked), for: .touchUpInside)
    }

    // MARK: - Action
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        viewModel.postUserLogin { userData, error in
            DispatchQueue.main.async {
                if let _ = error {
                    let alert = UIAlertController(title: "로그인 실패", message: "다시 확인하세요", preferredStyle: .alert)
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
    
    @objc func dontHaveAccountButtonClicked() {
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

