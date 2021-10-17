//
//  MainCell.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/15.
//

import UIKit

class MainCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var starringLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
