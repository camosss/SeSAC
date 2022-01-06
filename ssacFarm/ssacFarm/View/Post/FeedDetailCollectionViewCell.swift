//
//  FeedDetailCollectionViewCell.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

protocol FeedDetailCollectionViewCellDelegate: AnyObject {
    func cell(_ cell: FeedDetailCollectionViewCell)
}

class FeedDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let tk = TokenUtils()
    
    weak var delegate: FeedDetailCollectionViewCellDelegate?

    var viewModel: CommentViewModel? {
        didSet { configureData() }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.numberOfLines = 0
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
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(cellEditButtonTapped), for: .touchUpInside)
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
    
    @objc func cellEditButtonTapped() {
        delegate?.cell(self)
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
            make.trailing.equalTo(-80)
        }
        
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(16)
            make.leading.equalTo(stack)
            make.trailing.equalTo(-30)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(stack)
            make.trailing.equalTo(-20)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
    }
    
    func configureData() {
        guard let viewModel = viewModel else { return }

        nameLabel.text = viewModel.name
        commentLabel.text = viewModel.text
        dateLabel.text = Utility.dateFormat(dateString: viewModel.date)
        
        let id = self.tk.load("\(Endpoint.auth_register.url)", account: "id") ?? ""
        if id != "\(viewModel.comment.user.id)" {
            editButton.isHidden = true
        } else {
            editButton.isHidden = false
        }
    }
}

