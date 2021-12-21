//
//  FoodParingTableViewCell.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit
import SnapKit

class FoodParingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier = "FoodParingTableViewCell"
    
    var beer: Beer? {
        didSet { configure() }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Food"
        return label
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(30)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Helper
    
    func configure() {
        guard let beer = beer else { return }
        
//        print(beer.foodPairing.count, beer.foodPairing)
        
        
    }

}
