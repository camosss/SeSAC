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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "footerView"
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
}
