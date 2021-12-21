//
//  DescriptionTableViewCell.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit
import SnapKit

class DescriptionTableViewCell: UITableViewCell {
    
    let descriptionView: DescriptionView = {
        let view = DescriptionView()
        view.backgroundColor = .magenta
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionView)
        descriptionView.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
