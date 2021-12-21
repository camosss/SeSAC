//
//  DescriptionTableViewCell.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit
import SnapKit

protocol DescriptionTableViewCellDelegate: AnyObject {
    func cell(_ cell: DescriptionTableViewCell)
}

class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier = "DescriptionTableViewCell"
    
    weak var delegate: DescriptionTableViewCellDelegate?

    var beer: Beer? {
        didSet { configure() }
    }
    
    let descriptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.text = "tagline"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("more", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Action
    
    @objc func didTapMoreButton() {
        delegate?.cell(self)
    }
    
    // MARK: - Helper
    
    func configure() {
        guard let beer = beer else { return }
        
        nameLabel.text = beer.name
        taglineLabel.text = beer.tagline
        descriptionLabel.text = beer.description
    }
    
    func setViewConstraints() {
        contentView.addSubview(descriptionView)
        descriptionView.layer.shadowOpacity = 0.3
        descriptionView.layer.shadowRadius = 10
        descriptionView.layer.shadowOffset = .init(width: 0, height: -5)
        descriptionView.layer.shadowColor = UIColor.lightGray.cgColor
        
        descriptionView.snp.makeConstraints { make in
            make.top.trailing.equalTo(-20)
            make.leading.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        let firstStack = UIStackView(arrangedSubviews: [nameLabel, taglineLabel])
        firstStack.axis = .vertical
        firstStack.spacing = 20
        
        descriptionView.addSubview(firstStack)
        firstStack.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.centerX.equalToSuperview()
        }
        
        let secondStack = UIStackView(arrangedSubviews: [descriptionLabel, moreButton])
        secondStack.axis = .vertical
        secondStack.spacing = 10
        
        descriptionView.addSubview(secondStack)
        secondStack.snp.makeConstraints { make in
            make.top.equalTo(firstStack.snp.bottom).offset(20)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.centerX.equalToSuperview()
        }
    }
}
