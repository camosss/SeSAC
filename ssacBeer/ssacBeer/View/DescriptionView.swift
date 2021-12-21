//
//  DescriptionView.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit
import SnapKit

class DescriptionView: UIView {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textAlignment = .center
        return label
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.text = "tagline"
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("more", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .black
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Helper
    
    func setupView() {
        backgroundColor = .orange
        
        let firstStack = UIStackView(arrangedSubviews: [nameLabel, taglineLabel])
        firstStack.axis = .vertical
        firstStack.spacing = 20
        
        addSubview(firstStack)
        firstStack.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
        let secondStack = UIStackView(arrangedSubviews: [descriptionLabel, moreButton])
        secondStack.axis = .vertical
        secondStack.spacing = 20
        
        addSubview(secondStack)
        secondStack.snp.makeConstraints { make in
            make.top.equalTo(firstStack.snp.bottom).offset(20)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.centerX.equalToSuperview()
        }
    }
}
