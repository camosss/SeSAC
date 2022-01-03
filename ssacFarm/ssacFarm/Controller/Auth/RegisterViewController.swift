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
        print("loginButtonTapped \(viewModel.formIsValid)")
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
