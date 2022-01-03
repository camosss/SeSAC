//
//  SignView.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class SignView: UIView {
    
    // MARK: - Properties
    
    var emailTextField: UITextField = {
        let tf = Utility().textField(withPlaceholder: "이메일을 입력해주세요. 예) SeSAC@gmail.com")
        return tf
    }()
    var nameTextField: UITextField = {
        let tf = Utility().textField(withPlaceholder: "이름을 입력해주세요. 예) SeSAC")
        return tf
    }()
    var passwordTextField: UITextField = {
        let tf = Utility().textField(withPlaceholder: "비밀번호를 입력해주세요.")
        tf.isSecureTextEntry = true
        return tf
    }()
    var rePasswordTextField: UITextField = {
        let tf = Utility().textField(withPlaceholder: "다시 한번 비밀번호를 입력해주세요.")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utility().inputContainerView(textField: emailTextField)
        return view
    }()
    lazy var nameContainerView: UIView = {
        let view = Utility().inputContainerView(textField: nameTextField)
        return view
    }()
    private lazy var passwordContainerView: UIView = {
        let view = Utility().inputContainerView(textField: passwordTextField)
        return view
    }()
    lazy var rePasswordContainerView: UIView = {
        let view = Utility().inputContainerView(textField: rePasswordTextField)
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func setupConstraints() {
        let textFieldStack = UIStackView(arrangedSubviews: [emailContainerView, nameContainerView, passwordContainerView, rePasswordContainerView])
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 10
        
        addSubview(textFieldStack)
        textFieldStack.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStack.snp.bottom).offset(50)
            make.leading.trailing.equalTo(textFieldStack)
        }
    }
}
