//
//  SearchCollectionViewCell.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 10
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 3
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.trailing.bottom.equalTo(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
