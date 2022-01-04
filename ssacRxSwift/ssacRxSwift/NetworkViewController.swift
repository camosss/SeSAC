//
//  NetworkViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/04.
//

import UIKit
import RxSwift
import RxAlamofire

class NetworkViewController: UIViewController {
    
    // MARK: - Properties
    
    let label = UILabel()
    let disposeBag = DisposeBag()
    
//    let number = PublishSubject<String>()
    let number = BehaviorSubject<String>(value: "오늘의 운세")

    let urlString = "https://aztro.sameerkumar.website?sign=aries&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.backgroundColor = .white
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        useRxAlamofire()
    }
    
    // MARK: - Helper
    
    func useRxAlamofire() {
        number
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        json(.post, urlString)
            .subscribe { value in
                print(value)
                
                // JSONSerizlization
                guard let data = value as? [String: Any] else { return }
                guard let result = data["lucky_number"] as? String else { return }
                
                self.number.onNext(result)
                
            } onError: { error in
                print(error)
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    func useURLSession(url: String) -> Observable<String> {
        return Observable.create { value in
            
            let url = URL(string: self.lottoURL)!
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                
                // response 생략
                if let data = data, let json = String(data: data, encoding: .utf8) {
                    return value.onNext("\(data), \(json)")
                }
                
                value.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
