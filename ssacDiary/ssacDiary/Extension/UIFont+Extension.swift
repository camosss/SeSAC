//
//  UIFont+Extension.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit.UIFont

/*
--> S-CoreDream-2ExtraLight
--> S-CoreDream-5Medium
--> S-CoreDream-9Black
 */

extension UIFont {
    var mainBold: UIFont {
        return UIFont(name: "S-CoreDream-9Black", size: 20)!
    }
    
    var mainDemiBold: UIFont {
        return UIFont(name: "S-CoreDream-5Medium", size: 20)!
    }
    
    var mainLight: UIFont {
        return UIFont(name: "S-CoreDream-2ExtraLight", size: 20)!
    }
}
