//
//  FeedDetailCollectionViewCell.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

class FeedDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    var viewModel: CommentViewModel? {
        didSet { configureData() }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "ddd"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
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
        let stack = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(16)
            make.leading.trailing.equalTo(stack)
        }
    }
    
    func configureData() {
        guard let viewModel = viewModel else { return }

        nameLabel.text = viewModel.name
        commentLabel.text = viewModel.text
        dateLabel.text = Utility.dateFormat(dateString: viewModel.date)
    }
}

