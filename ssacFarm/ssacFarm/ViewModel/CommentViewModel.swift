//
//  CommentViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import UIKit

struct CommentViewModel {
    var comment: Comment

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
    
    init(comment: Comment) {
        self.comment = comment
    }
}

struct CommentAPIViewModel {
    func getCommentData(token: String, postId: Int, completion: @escaping (Comments?, APIError?) -> Void) {
        APIService.commentInquire(token: token, postId: postId) { comments, error in
            if let error = error {
                completion(nil, error)
            }
            guard let comments = comments else { return }
            completion(comments, nil)
        }
    }
    
    func writeCommentData(token: String, postId: Int, comment: String, completion: @escaping (Comment?, APIError?) -> Void) {
        APIService.commentWrite(token: token, postId: postId, comment: comment) { comment, error in
            if let error = error {
                completion(nil, error)
            }
            guard let comment = comment else { return }
            completion(comment, nil)
        }
    }
    
    func editCommentData(token: String, commentId: Int, postId: Int, text: String, completion: @escaping (Comment?, APIError?) -> Void) {
        APIService.commentEdit(token: token, id: commentId, postId: postId, comment: text) { comment, error in
            if let error = error {
                completion(nil, error)
            }
            guard let comment = comment else { return }
            completion(comment, nil)
        }
    }
    
    func deleteCommentData(token: String, id: Int, completion: @escaping (Comment?, APIError?) -> Void) {
        APIService.commentDelete(id: id, token: token) { comment, error in
            if let error = error {
                completion(nil, error)
            }
            guard let comment = comment else { return }
            completion(comment, nil)
        }
    }
}
