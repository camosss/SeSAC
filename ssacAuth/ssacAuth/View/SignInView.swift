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
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입 하러가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
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
        addSubview(passwordTextField)
        addSubview(signInButton)
        addSubview(dontHaveAccountButton)
        
        usernameTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
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
        
        dontHaveAccountButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.width.height.equalTo(usernameTextField)
            make.centerX.equalToSuperview()
        }
    }
}
