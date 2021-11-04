//
//  ShoppingCell.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/03.
//

import UIKit

protocol ShoppingCellDelegate: AnyObject {
    func isChecked(_ cell: ShoppingCell)
    func isStared(_ cell: ShoppingCell)
}

class ShoppingCell: UITableViewCell {
    
    // MARK: - Properties
        
    weak var delegate: ShoppingCellDelegate?
    
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Action
    
    @IBAction func tapCheck(_ sender: UIButton) {
        delegate?.isChecked(self)
    }
    
    @IBAction func tapStar(_ sender: UIButton) {
        delegate?.isStared(self)
    }
    
}
