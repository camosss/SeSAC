//
//  CommentViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import UIKit

struct CommentViewModel {
    var comment: CommentElement

    var name: String { return comment.user.username }
    var text: String { return comment.comment }
    var date: String { return comment.updatedAt }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = comment.comment
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    init(comment: CommentElement) {
        self.comment = comment
    }
}
