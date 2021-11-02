//
//  SearchCell.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit

class SearchCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "SearchCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
