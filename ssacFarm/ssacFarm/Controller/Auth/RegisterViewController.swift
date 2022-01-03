//
//  RegisterViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    let signView = SignView()
    var viewModel = RegisterViewModel()

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "새싹농장 회원가입"
        
        setSignView()
    }
    
    // MARK: - Action
    
    @objc func loginButtonTapped() {
        guard let email = signView.emailTextField.text else { return }
        guard let name = signView.nameTextField.text else { return }
        guard let password = signView.passwordTextField.text else { return }
        guard let repassword = signView.rePasswordTextField.text else { return }

        if password != repassword {
            self.view.makeToast("비밀번호가 일치하지 않습니다.")
            return
        }
                
        APIService.register(username: name, email: email, password: password) { user, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.view.makeToast("이미 있는 회원 정보입니다. 다시 시도해주세요.")
                }
                return
            }
            
            if let _ = user {
                AlertHelper.confirmAlert(title: "환영합니다!", message: "회원가입을 완료했습니다.", okMessage: "로그인 하러가기", onConfirm: {
                    self.navigationController?.popViewController(animated: true)
                }, over: self)
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == signView.emailTextField {
            viewModel.email = sender.text
        } else if sender == signView.nameTextField {
            viewModel.name = sender.text
        } else if sender == signView.passwordTextField {
            viewModel.password = sender.text
        } else {
            viewModel.repassword = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helper
    
    func setSignView() {
        signView.loginButton.setTitle("회원가입", for: .normal)
        signView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        signView.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        signView.nameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        signView.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        signView.rePasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension RegisterViewController: FormViewModel {
    func updateForm() {
        signView.loginButton.isEnabled = viewModel.formIsValid
        signView.loginButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
