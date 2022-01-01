//
//  FeedDetailCollectionViewCell.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

class FeedDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글 댓글"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
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
        let stack = UIStackView(arrangedSubviews: [nameLabel, commentLabel])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
}

