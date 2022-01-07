//
//  RegisterViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    let authView = AuthView()
    var viewModel = RegisterViewModel()

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "새싹농장 회원가입"
        
        setSignView()
        hideContainerView()
    }
    
    // MARK: - Action
    
    @objc func loginButtonTapped() {
        guard let email = authView.emailTextField.text else { return }
        guard let name = authView.nameTextField.text else { return }
        guard let password = authView.passwordTextField.text else { return }
        guard let repassword = authView.rePasswordTextField.text else { return }

        if password != repassword {
            self.view.makeToast("비밀번호가 일치하지 않습니다.")
            return
        }
        
        viewModel.postUserRegisterData(name: name, email: email, password: password) { user, error in
            if let _ = error {
                self.view.makeToast("이미 있는 회원 정보입니다. 다시 시도해주세요.")
                return
            }
            
            if let _ = user {
                self.view.makeToast("환영합니다! 회원가입을 완료했습니다. 🌱", duration: 1.0, position: .center)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == authView.emailTextField {
            viewModel.email = sender.text
        } else if sender == authView.nameTextField {
            viewModel.name = sender.text
        } else if sender == authView.passwordTextField {
            viewModel.password = sender.text
        } else {
            viewModel.repassword = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helper
    
    func setSignView() {
        authView.authButton.setTitle("회원가입", for: .normal)
        authView.authButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        authView.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authView.nameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authView.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authView.rePasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func hideContainerView() {
        authView.currentPasswordTextFieldContainerView.isHidden = true
        authView.newPasswordContainerView.isHidden = true
        authView.confirmPasswordTextFieldContainerView.isHidden = true
    }
}

// MARK: - FormViewModel

extension RegisterViewController: FormViewModel {
    func updateForm() {
        authView.authButton.isEnabled = viewModel.formIsValid
        authView.authButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
