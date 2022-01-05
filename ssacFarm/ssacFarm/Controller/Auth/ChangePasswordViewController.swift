//
//  ChangePasswordViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/06.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    let passwordView = PasswordView()
    var viewModel = PasswordViewModel()

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "비밀번호 변경"
        view.backgroundColor = .white
        setSignView()
    }
    
    // MARK: - Action
    
    @objc func loginButtonTapped() {
        guard let currentPassword = passwordView.currentPasswordTextField.text else { return }
        guard let newPassword = passwordView.newPasswordTextField.text else { return }
        guard let confirmPassword = passwordView.confirmPasswordTextField.text else { return }

        viewModel.changeUserPassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmPassword) { user, error in
            if let error = error {
                print("controller \(error)")
                return
            }
            
            if let _ = user {
                self.view.makeToast("비밀번호를 변경하였습니다!")

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == passwordView.currentPasswordTextField {
            viewModel.currentPassword = sender.text
        } else if sender == passwordView.newPasswordTextField {
            viewModel.newPassword = sender.text
        } else {
            viewModel.confirmPassword = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helper
    
    func setSignView() {
        passwordView.changeButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        passwordView.currentPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordView.newPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordView.confirmPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
}

// MARK: - FormViewModel

extension ChangePasswordViewController: FormViewModel {
    func updateForm() {
        passwordView.changeButton.isEnabled = viewModel.formIsValid
        passwordView.changeButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
