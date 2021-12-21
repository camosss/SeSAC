//
//  DescriptionTableViewCell.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit
import SnapKit

class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier = "DescriptionTableViewCell"
    
    let descriptionView: DescriptionView = {
        let view = DescriptionView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionView)
        descriptionView.snp.makeConstraints { make in
            make.top.trailing.equalTo(-20)
            make.leading.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
