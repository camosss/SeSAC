//
//  DetailCell.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/17.
//

import UIKit

class DetailCell: UITableViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var directorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
