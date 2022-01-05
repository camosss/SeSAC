//
//  VaildationViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/05.
//

import UIKit
import RxSwift
import RxRelay

class VaildationViewModel {
    var validText = BehaviorRelay<String>(value: "최소 6자 이상 필요해요")
}

class VaildationViewController: UIViewController {
    
    // MARK: - Properties
    
    let nameVaildationLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    let viewModel = VaildationViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.validText
            .asDriver()
            .drive(nameVaildationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let vaildation = nameTextField.rx.text
            .orEmpty
            .map { $0.count >= 6 }
            .share(replay: 1, scope: .whileConnected)
     
        vaildation
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        vaildation
            .bind(to: nameVaildationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
    }
    
    // MARK: - Helper
    
    func setup() {
        view.backgroundColor = .systemTeal
        button.setTitle("전환", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        [nameTextField, button, nameVaildationLabel].forEach {
            $0.backgroundColor = .white
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        nameVaildationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(nameVaildationLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }

}
