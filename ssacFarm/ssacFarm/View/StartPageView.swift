//
//  StartPageView.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class StartPageView: UIView {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "logo_ssac_white")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "당신 근처의 새싹농장"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = Utility.attributedButton("이미 계정이 있나요?  ", "로그인")
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
        let stack = UIStackView(arrangedSubviews: [logoImageView, titleLabel, subTitleLabel])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(250)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: [startButton, alreadyHaveAccountButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 10
        
        addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
        }
    }
}
