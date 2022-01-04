//
//  Subject.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/04.
//

import UIKit
import RxSwift

class Subject: UIViewController {
    
    // MARK: - Properties
    
    let label = UILabel()
    let disposeBag = DisposeBag()
    
//    let name = Observable.just("A")
    let name = PublishSubject<String>()
    
    let arr1 = [1, 1, 1, 1, 1, 1]
    let arr2 = [2, 2, 2, 2, 2, 2]
    let arr3 = [3, 3, 3, 3, 3, 3]

    let subject = PublishSubject<[Int]>()
    let behavior = BehaviorSubject<[Int]>(value: [0, 0, 0, 0, 0])
    let replay = ReplaySubject<[Int]>.create(bufferSize: 2)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random1 = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        random1
            .subscribe { value in
                print("random1 \(value)")
            }
            .disposed(by: disposeBag)
        
        random1
            .subscribe { value in
                print("random2 \(value)")
            }
            .disposed(by: disposeBag)
        
        let randomSubject = BehaviorSubject(value: 0)
        randomSubject.onNext(Int.random(in: 1...100))
        
        randomSubject.subscribe { value in
            print("randomSubject1 \(value)")
        }
        .disposed(by: disposeBag)
        
        randomSubject.subscribe { value in
            print("randomSubject2 \(value)")
        }
        .disposed(by: disposeBag)
    }
    
    // MARK: - Helper
    
    func replaySubject() {
        // 가장 최신 기준
        replay.onNext(arr1)
        replay.onNext(arr2)
        replay.onNext(arr3)
        
        replay
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext([5, 5, 5, 5])
    }
    
    func behaviorSubject() {
        behavior.onNext(arr2)
        behavior
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    func publishSubject() {
        subject.onNext(arr1)
        subject
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(arr2)
    }
    
    func aboutSubject() {
        setup()
        
        name
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.name.onNext("Before")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.name.onNext("After")
        }
    }
    
    func setup() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.backgroundColor = .white
        label.textAlignment = .center
    }
}

