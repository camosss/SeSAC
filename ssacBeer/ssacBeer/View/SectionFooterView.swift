//
//  SectionFooterView.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit
import SnapKit

class SectionFooterView: UIView {
    
    // MARK: - Properties
    
    var beer: Beer? {
        didSet { configure() }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Helper
    
    func configure() {
        guard let beer = beer else { return }

        titleLabel.text = beer.brewersTips
    }
}
