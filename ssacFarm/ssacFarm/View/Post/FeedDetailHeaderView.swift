//
//  FeedDetailHeaderView.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

class FeedDetailHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifer = "FeedDetailHeaderView"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12/09"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        return view
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let commentButton: UIButton = {
        let button = Utility().attributedImageButton(UIImage(systemName: "bubble.right")!, "  댓글")
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var stackView: UIView = {
        let view = UIView()
        
        let divider1 = UIView()
        divider1.backgroundColor = .lightGray
        divider1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        view.addSubview(divider1)
        divider1.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.leading.trailing.equalToSuperview()
        }
        
        let commentStack = UIStackView(arrangedSubviews: [commentButton, countLabel])
        commentStack.axis = .horizontal
        commentStack.spacing = 5
        
        view.addSubview(commentStack)
        commentStack.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(5)
            make.leading.equalTo(10)
        }
        
        let divider2 = UIView()
        divider2.backgroundColor = .lightGray
        divider2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(divider2)
        divider2.snp.makeConstraints { make in
            make.top.equalTo(commentButton.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
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
    
    // MARK: - Action
    
    @objc func commentButtonTapped() {
        print("commentButtonTapped")
    }
    
    // MARK: - Helper
    
    func setupConstraints() {
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, dateLabel, dividerView])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.leading.equalTo(30)
            make.trailing.equalToSuperview()
        }
        
        addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.leading.equalTo(stack)
            make.trailing.equalTo(-10)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(40)
            make.leading.equalTo(15)
            make.trailing.equalToSuperview()
        }
    }
}
