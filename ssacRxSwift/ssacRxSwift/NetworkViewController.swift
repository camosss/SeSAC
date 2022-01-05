//
//  NetworkViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/04.
//

import UIKit
import RxSwift
import RxAlamofire

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

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
        
//        useRxAlamofire()
        
        number
            .bind(to: label.rx.text)
        
        // 위와 동일 (bind)
//            .observe(on: MainScheduler.instance) // observeon vs subscribeon
//            .subscribe { value in
//                self.label.text = value
//            }
            .disposed(by: disposeBag)
        
        
        let request = useURLSession()
            .share() // 여러번의 요청 (dataTask가 한번)
            .decode(type: Lotto.self, decoder: JSONDecoder())
        
        request
            .subscribe { value in
                print("value1")
            }.disposed(by: disposeBag)
        
        request
            .subscribe { value in
                print("value2")
            }.disposed(by: disposeBag)
        
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
    
    func useURLSession() -> Observable<Data> {
        return Observable.create { value in
            
            let url = URL(string: self.lottoURL)!
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                
                if let data = data {
                    print("dataTask")
                    value.onNext(data)
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
