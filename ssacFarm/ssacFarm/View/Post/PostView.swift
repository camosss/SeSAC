//
//  PostView.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import UIKit

class PostView: UIView {
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    let commentButton: UIButton = {
        let button = Utility.attributedImageButton(UIImage(systemName: "bubble.right")!, "  댓글")
        return button
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        return view
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
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        labelStack.axis = .vertical
        labelStack.distribution = .fillProportionally
        labelStack.spacing = 5
        
        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(nameLabel)
        }
        
        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        let commentStack = UIStackView(arrangedSubviews: [commentButton, countLabel])
        commentStack.axis = .horizontal
        commentStack.spacing = 5
        
        addSubview(commentStack)
        commentStack.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(5)
            make.leading.equalTo(30)
        }
        
        addSubview(dividerView2)
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(commentStack.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-5)
        }
    }
}
