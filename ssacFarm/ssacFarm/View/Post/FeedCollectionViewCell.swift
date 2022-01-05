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
    
    var viewModel: PostDataViewModel? {
        didSet { configureData() }
    }
    
    weak var delegate: FeedCollectionViewCellDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
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
        let button = Utility.attributedImageButton(UIImage(systemName: "bubble.right")!, "  댓글")
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
    
    func configureData() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        contentLabel.text = viewModel.text
        dateLabel.text = Utility.dateFormat(dateString: viewModel.date)
        countLabel.text = "\(viewModel.comment)"
    }
    
    func setupConstraints() {
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        labelStack.axis = .vertical
        labelStack.distribution = .fillProportionally
        labelStack.spacing = 5

        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(10)
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
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
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
            make.bottom.equalTo(-10)
        }
    }
}
