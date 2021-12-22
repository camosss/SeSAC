//
//  SearchCollectionViewHeader.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class SearchCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static var identifier = "SearchCollectionViewHeader"
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 및 TV 프로그램"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
