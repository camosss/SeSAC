//
//  HomeCell.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "HomeTableViewCell"
    
    @IBOutlet weak var categoryLabel: UILabel!    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
