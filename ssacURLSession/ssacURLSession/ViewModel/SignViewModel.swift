//
//  SignViewModel.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class SignViewModel {
    
    var navigationTitle: String = "Navigation Title"
    var buttonTitle: String = "Sign up"
    
    func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    var text: String = "" {
        didSet {
            let count = text.count
            let value = count >= 100 ? "작성할 수 없습니다" : "\(count)/100"
            let color: UIColor = count >= 100 ? .red : .black
            
            listener?(value, color) // 데이터 전달
        }
    }
    
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        // 해당 클로저 구문은 text의 didSet에서 실행
        self.listener = listener
    }
}
