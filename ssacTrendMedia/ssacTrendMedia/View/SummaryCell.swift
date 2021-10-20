//
//  SummaryCell.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/20.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
