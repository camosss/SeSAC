//
//  GradeCalculator.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GradeCalculator: UIViewController {
    
    // MARK: - Properties
    
    let mySwitch = UISwitch()
    let disposeBag = DisposeBag()
    
    let first = UITextField()
    let second = UITextField()
    let resultLabel = UILabel()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setup()
        
        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty) { text1, text2 -> String in
            return String(((Double(text1) ?? 0.0) + (Double(text2) ?? 0.0)) / 2)
        }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
        
        Observable.of(false)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper
    
    func setup() {
        view.addSubview(mySwitch)
        mySwitch.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.addSubview(first)
        view.addSubview(second)
        view.addSubview(resultLabel)
        
        first.backgroundColor = .white
        second.backgroundColor = .white
        resultLabel.backgroundColor = .white
        resultLabel.textColor = .systemPink
        
        first.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        second.snp.makeConstraints { make in
            make.top.size.equalTo(first)
            make.leading.equalTo(first.snp.trailing).offset(10)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(first.snp.bottom).offset(10)
            make.size.equalTo(50)
            make.leading.equalTo(first).offset(30)
        }
    }
    
}
