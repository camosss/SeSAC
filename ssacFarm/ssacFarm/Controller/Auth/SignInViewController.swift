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
    
    let authView = AuthView()
    var viewModel = SignInViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "새싹농장 로그인"
        
        setSignView()
        hideContainerView()
    }
    
    // MARK: - Action
    
    @objc func loginButtonTapped() {
        guard let email = authView.emailTextField.text else { return }
        guard let password = authView.passwordTextField.text else { return }
        
        viewModel.postUserLoginData(email: email, password: password) { user, error in
            if let _ = error {
                self.view.makeToast("로그인에 실패했습니다. 다시 시도해주세요.")
                return
            }
            
            if let _ = user {
                self.view.makeToast("로그인 되었습니다. 🌱", duration: 1.0, position: .center)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: FeedViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                }
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == authView.emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helper
    
    func setSignView() {
        authView.authButton.setTitle("로그인", for: .normal)
        authView.authButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        authView.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authView.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func hideContainerView() {
        authView.nameContainerView.isHidden = true
        authView.rePasswordContainerView.isHidden = true
        authView.currentPasswordTextFieldContainerView.isHidden = true
        authView.newPasswordContainerView.isHidden = true
        authView.confirmPasswordTextFieldContainerView.isHidden = true
    }
}

// MARK: - FormViewModel

extension SignInViewController: FormViewModel {
    func updateForm() {
        authView.authButton.isEnabled = viewModel.formIsValid
        authView.authButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
