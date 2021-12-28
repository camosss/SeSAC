//
//  Observable.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/27.
//

import Foundation

class Observable<T> {
    private var listener: ((T) -> Void)?
    
    // value가 변경될때마다 클로저 구문 실행
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

