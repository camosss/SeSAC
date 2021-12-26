//
//  SearchCollectionViewCell.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureImage(tvShow: TvShow) {
        let imageUrl = "https://image.tmdb.org/t/p/original/\(tvShow.backdropPath ?? "")"
        postImageView.setImage(imageUrl: imageUrl)
    }
    
}
