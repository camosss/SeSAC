//
//  VaildationViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

protocol CommonViewModel {
    // associatedtype = Generic과 동일한 개념
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class VaildationViewModel: CommonViewModel {
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let result = input.text
            .orEmpty
            .map { $0.count >= 6 }
            .share(replay: 1, scope: .whileConnected)
        return Output(validStatus: result, validText: validText, sceneTransition: input.tap)
    }
    
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
        bind() // MVVM 패턴
        
//        viewModel.validText
//            .asDriver()
//            .drive(nameVaildationLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        let vaildation = nameTextField.rx.text
//            .orEmpty
//            .map { $0.count >= 6 }
//            .share(replay: 1, scope: .whileConnected)
//
//        vaildation
//            .bind(to: button.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        vaildation
//            .bind(to: nameVaildationLabel.rx.isHidden)
//            .disposed(by: disposeBag)
//
//        button.rx.tap
//            .subscribe { _ in
//                self.present(ReactiveViewController(), animated: true, completion: nil)
//            }.disposed(by: disposeBag)
        
    }
    
    // MARK: - Helper
    
    func bind() {
        let input = VaildationViewModel.Input(text: nameTextField.rx.text, tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: button.rx.isEnabled, nameVaildationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validText
            .asDriver()
            .drive(nameVaildationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
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

