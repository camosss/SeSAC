//
//  RegisterView.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/29.
//

import UIKit
import SnapKit

class RegisterView: UIView, ViewRepresentable {
    
    // MARK: - Properties
    
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper
    
    func setupView() {
        addSubview(usernameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
        
        usernameTextField.backgroundColor = .white
        emailTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.width.height.equalTo(usernameTextField)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.height.equalTo(usernameTextField)
            make.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.height.equalTo(usernameTextField)
            make.centerX.equalToSuperview()
        }
    }
}
