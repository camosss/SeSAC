//
//  MemoTableViewCell.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MemoTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
