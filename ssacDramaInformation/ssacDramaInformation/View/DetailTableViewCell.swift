//
//  DetailTableViewCell.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties
        
    private let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 5
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    // MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helper
    
    func configureUI(season: Season) {
        let imageUrl = "https://image.tmdb.org/t/p/original/\(season.posterPath ?? "")"
        postImageView.setImage(imageUrl: imageUrl)
        
        seasonLabel.text = "Season \(season.seasonNumber ?? 0)"
        dateLabel.text = season.airDate
        episodeLabel.text = "| Episode \(season.episodeCount ?? 0)"
        descriptionLabel.text = season.overview
    }
    
    func setConstraints() {
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(seasonLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(episodeLabel)
        contentView.addSubview(descriptionLabel)
        
        postImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView)
            make.leading.equalTo(postImageView.snp.trailing).offset(10)
            make.height.equalTo(20)
        }

        seasonLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(postImageView.snp.trailing).offset(10)
            make.height.equalTo(16)
        }
        
        episodeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(3)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(7)
            make.bottom.trailing.equalTo(-10)
            make.leading.equalTo(titleLabel)
        }
    }
}

