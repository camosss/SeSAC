//
//  PopUpService+Extension.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/11.
//

import UIKit

class PopUpService {
    
    func popup() -> PopUpViewController {
        let sb = UIStoryboard(name: "PopUp", bundle: .main)
        let popupVC = sb.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        return popupVC
    }
}
