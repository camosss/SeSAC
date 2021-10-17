//
//  SearchCell.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/17.
//

import UIKit

class SearchCell: UITableViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
