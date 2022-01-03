//
//  PickerViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let pickerView = UIPickerView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickerView()
        configurePickerView()
    }
    
    // MARK: - Helper
    
    func setUpPickerView() {
        view.backgroundColor = .systemGray6
        view.addSubview(pickerView)
        pickerView.backgroundColor = .white
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func configurePickerView() {
        let items = Observable.just([
            "영화",
            "드라마",
            "애니메이션"
        ])
        
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }
    
}



