//
//  PostViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

struct ButtonViewModel {
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


struct PostViewModel {
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

struct PostAPIViewModel {
    func getPostData(token: String, completion: @escaping (Posts?, APIError?) -> Void) {
        APIService.postInquire(token: token) { posts, error in
            if let error = error {
                completion(nil, error)
            }
            guard let posts = posts else { return }
            completion(posts, nil)
        }
    }
    
    func getPostDetailData(token: String, postId: Int, completion: @escaping (Post?, APIError?) -> Void) {
        APIService.postDetailInquire(id: postId, token: token) { post, error in
            if let error = error {
                completion(nil, error)
            }
            guard let post = post else { return }
            completion(post, nil)
        }
    }
    
    func writePostData(token: String, text: String, completion: @escaping (Post?, APIError?) -> Void) {
        APIService.postWrite(token: token, text: text) { post, error in
            if let error = error {
                completion(nil, error)
            }
            guard let post = post else { return }
            completion(post, nil)
        }
    }
    
    func editPostData(token: String, postId: Int, text: String, completion: @escaping (Post?, APIError?) -> Void) {
        APIService.postEdit(id: postId, token: token, text: text) { post, error in
            if let error = error {
                completion(nil, error)
            }
            guard let post = post else { return }
            completion(post, nil)
        }
    }
    
    func deletePostData(token: String, id: Int, completion: @escaping (Post?, APIError?) -> Void) {
        APIService.postDelete(id: id, token: token) { post, error in
            if let error = error {
                completion(nil, error)
            }
            guard let post = post else { return }
            completion(post, nil)
        }
    }
}
