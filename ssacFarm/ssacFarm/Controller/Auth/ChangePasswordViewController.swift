//
//  ChangePasswordViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/06.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    let authView = AuthView()
    var viewModel = PasswordViewModel()

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "비밀번호 변경"
        view.backgroundColor = .white
        setSignView()
        hideContainerView()
    }
    
    // MARK: - Action
    
    @objc func loginButtonTapped() {
        guard let currentPassword = authView.currentPasswordTextField.text else { return }
        guard let newPassword = authView.newPasswordTextField.text else { return }
        guard let confirmPassword = authView.confirmPasswordTextField.text else { return }

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
        if sender == authView.currentPasswordTextField {
            viewModel.currentPassword = sender.text
        } else if sender == authView.newPasswordTextField {
            viewModel.newPassword = sender.text
        } else {
            viewModel.confirmPassword = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helper
    
    func setSignView() {
        authView.authButton.setTitle("변경하기", for: .normal)
        authView.authButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        authView.currentPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authView.newPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authView.confirmPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func hideContainerView() {
        authView.nameContainerView.isHidden = true
        authView.emailContainerView.isHidden = true
        authView.passwordContainerView.isHidden = true
        authView.rePasswordContainerView.isHidden = true
    }
}

// MARK: - FormViewModel

extension ChangePasswordViewController: FormViewModel {
    func updateForm() {
        authView.authButton.isEnabled = viewModel.formIsValid
        authView.authButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
