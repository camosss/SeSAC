//
//  CommentViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/05.
//

import Foundation

struct CommentViewModel {
    var comment: Comment

    var name: Int { return comment.user }
    var text: String { return comment.comment }
    
    init(comment: Comment) {
        self.comment = comment
    }
}
