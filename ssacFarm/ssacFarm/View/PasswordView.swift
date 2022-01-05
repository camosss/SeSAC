//
//  PasswordView.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/06.
//

import UIKit

class PasswordView: UIView {
    
    // MARK: - Properties
    
    var currentPasswordTextField: UITextField = {
        let tf = Utility.textField(withPlaceholder: "현재 비밀번호를 입력해주세요.")
        tf.isSecureTextEntry = true
        return tf
    }()
    var newPasswordTextField: UITextField = {
        let tf = Utility.textField(withPlaceholder: "변경하실 비밀번호를 입력해주세요.")
        tf.isSecureTextEntry = true
        return tf
    }()
    var confirmPasswordTextField: UITextField = {
        let tf = Utility.textField(withPlaceholder: "변경하신 비밀번호를 다시 한번 입력해주세요.")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var currentPasswordTextFieldContainerView: UIView = {
        let view = Utility.inputContainerView(textField: currentPasswordTextField)
        return view
    }()
    private lazy var newPasswordContainerView: UIView = {
        let view = Utility.inputContainerView(textField: newPasswordTextField)
        return view
    }()
    private lazy var confirmPasswordTextFieldContainerView: UIView = {
        let view = Utility.inputContainerView(textField: confirmPasswordTextField)
        return view
    }()
    
    let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("변경하기", for: .normal)
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
        let textFieldStack = UIStackView(arrangedSubviews: [currentPasswordTextFieldContainerView, newPasswordContainerView, confirmPasswordTextFieldContainerView])
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 10
        
        addSubview(textFieldStack)
        textFieldStack.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        addSubview(changeButton)
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStack.snp.bottom).offset(50)
            make.leading.trailing.equalTo(textFieldStack)
        }
    }
}
