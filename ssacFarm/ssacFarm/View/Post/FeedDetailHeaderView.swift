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
    
    let postView = PostView()

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
    
    // MARK: - Helper
    
    func setPostView() {
        addSubview(postView)
        postView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureData() {
        guard let viewModel = viewModel else { return }
        
        postView.nameLabel.text = viewModel.name
        postView.contentLabel.text = viewModel.text
        postView.dateLabel.text = Utility.dateFormat(dateString: viewModel.date)
        postView.countLabel.text = "\(viewModel.comment)"
    }
}
