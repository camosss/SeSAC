//
//  SignInViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit
import Toast

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    let signView = SignView()
    var viewModel = SignInViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "새싹농장 로그인"
        
        setSignView()
    }
    
    // MARK: - Action
    
    @objc func loginButtonTapped() {
        guard let email = signView.emailTextField.text else { return }
        guard let password = signView.passwordTextField.text else { return }
        
        viewModel.postUserLoginData(email: email, password: password) { user, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.view.makeToast("로그인에 실패했습니다. 다시 시도해주세요.")
                }
                return
            }
            
            if let _ = user {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: FeedViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == signView.emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helper
    
    func setSignView() {
        signView.loginButton.setTitle("로그인", for: .normal)
        signView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        signView.nameContainerView.isHidden = true
        signView.rePasswordContainerView.isHidden = true
        
        signView.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        signView.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension SignInViewController: FormViewModel {
    func updateForm() {
        signView.loginButton.isEnabled = viewModel.formIsValid
        signView.loginButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
