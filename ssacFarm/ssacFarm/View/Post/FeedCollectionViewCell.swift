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
    
    let postView = PostView()
    
    weak var delegate: FeedCollectionViewCellDelegate?

    var viewModel: PostViewModel? {
        didSet { configureData() }
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPostView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func commentButtonTapped() {
        delegate?.cell(self)
    }
    
    // MARK: - Helper
    
    func setPostView() {
        addSubview(postView)
        postView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        postView.dividerView2.isHidden = true
        postView.commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    
    func configureData() {
        guard let viewModel = viewModel else { return }

        postView.nameLabel.text = viewModel.name
        postView.contentLabel.text = viewModel.text
        postView.dateLabel.text = Utility.dateFormat(dateString: viewModel.date)
        postView.countLabel.text = "\(viewModel.comment)"
    }
}
