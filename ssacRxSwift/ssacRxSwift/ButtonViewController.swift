//
//  ButtonViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/06.
//

import UIKit
import RxCocoa
import RxSwift

class ButtonViewModel: CommonViewModel {
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 반가워!" }
            .asDriver(onErrorJustReturn: "")
        return Output(text: result)
    }
}

class ButtonViewController: UIViewController {
    
    // MARK: - Properties
    
    let button = UIButton()
    let label = UILabel()
    
    let disposeBag = DisposeBag()
    let viewModel = ButtonViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        buttonEvent()
    }
    
    // MARK: - Helper
    
    func buttonEvent() {
//        button.rx.tap
//            .observe(on: MainScheduler.instance)
//            .subscribe { _ in
//                self.label.text = "안녕 반가워!"
//            }.disposed(by: disposeBag)
        
//        button.rx.tap
//            .map { return "안녕 반가워!" }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
//        button.rx.tap
//            .map { "안녕 반가워!" }
//            .asDriver(onErrorJustReturn: "")
//            .drive(label.rx.text)
//            .disposed(by: disposeBag)
        
        // MVVM
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.backgroundColor = .purple
        view.addSubview(button)
        view.addSubview(label)
        
        label.backgroundColor = .lightGray
        button.backgroundColor = .white
        
        button.setTitle("버튼", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
    
}
