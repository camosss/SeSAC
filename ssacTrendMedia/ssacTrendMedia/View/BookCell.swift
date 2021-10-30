//
//  BookCell.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/19.
//

import UIKit

class BookCell: UICollectionViewCell {

    // MARK: - Properties
    
    static let identifier = "BookCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
