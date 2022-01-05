//
//  PostViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

struct PostDataViewModel {
    var post: Post
    
    var name: String { return post.user.username }
    var text: String { return post.text }
    var date: String { return post.updatedAt }
    var comment: Int { return post.comments.count }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = post.text
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    init(post: Post) {
        self.post = post
    }
}

struct PostViewModel {
    var content: String?
    
    var formIsValid: Bool {
        return content?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemGreen : .white
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .systemGreen : .systemGray6
    }

}
