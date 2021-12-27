//
//  SignInView.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}

class SignInView: UIView, ViewRepresentable {
    
    // MARK: - Properties
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
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
        addSubview(passwordTextField)
        addSubview(signInButton)
        
        usernameTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
        signInButton.backgroundColor = .orange
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.width.height.equalTo(usernameTextField)
            make.centerX.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.height.equalTo(usernameTextField)
            make.centerX.equalToSuperview()
        }
    }
}
