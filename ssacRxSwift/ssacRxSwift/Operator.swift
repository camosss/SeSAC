//
//  Operator.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/03.
//

import UIKit
import RxSwift

enum ExampleError: Error {
    case fail
}

class Operator: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let items2 = [1.3, 4.4, 5.2, 2.1]
        
        // MARK: - Just
        
        Observable.just(items)
            .subscribe { value in
                print("just - \(value)")
            }
            .disposed(by: disposeBag)
        
        // MARK: - Of
        
        Observable.of(items, items2)
            .subscribe { value in
                print("of - \(value)")
            }
            .disposed(by: disposeBag)
        
        // MARK: - From
        
        Observable.from(items)
            .subscribe { value in
                print("from - \(value)")
            }
            .disposed(by: disposeBag)
        
        // MARK: - Create
        
        // Observable<Element>
        Observable<Double>.create { observer -> Disposable in
            
            for item in items {
                if item < 3.0 {
                    observer.onError(ExampleError.fail); break
                }
                observer.onNext(item)
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
        .subscribe { value in
            print(value)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: disposeBag)

        
    }
}
