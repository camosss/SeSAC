//
//  ChatViewModel.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/13.
//

import UIKit

struct ChatViewModel {
    
    var isChecked = false
    
    var messageBackgroundColor: UIColor {
        return isChecked ? .systemTeal : .white
    }
    
    var messageTextColor: UIColor {
        return isChecked ? .white : .black
    }
    
    var rightActive: Bool {
        return isChecked
    }
    
    var leftActive: Bool {
        return !isChecked
    }
    
    var shouldHideProfileImage: Bool {
        return isChecked
    }
}
