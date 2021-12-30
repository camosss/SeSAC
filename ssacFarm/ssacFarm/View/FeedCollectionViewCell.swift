//
//  FeedCollectionViewCell.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

protocol FeedCollectionViewCellDelegate: AnyObject {
    func cell(_ cell: FeedCollectionViewCell)
}

class FeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: FeedCollectionViewCellDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12/09"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        return view
    }()
    
    private let commentButton: UIButton = {
        let button = Utility().attributedImageButton(UIImage(systemName: "bubble.right")!, "  댓글쓰기")
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
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
    
    // MARK: - Action
    
    @objc func commentButtonTapped() {
        delegate?.cell(self)
    }
    
    // MARK: - Helper
    
    func setupConstraints() {
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(30)
        }
        
        let textStack = UIStackView(arrangedSubviews: [contentLabel, dateLabel])
        textStack.axis = .vertical
        textStack.spacing = 20
        
        addSubview(textStack)
        textStack.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(textStack.snp.bottom).offset(10)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        addSubview(commentButton)
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.leading.equalTo(30)
            make.bottom.equalTo(-10)
        }
    }
}
