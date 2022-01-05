//
//  ReactiveViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/05.
//

import UIKit
import RxSwift
import SnapKit
import RxRelay

struct SampleData {
    let user: String
    let age: Int
    let rate: Double
}

class ReactiveViewModel {
    var data = [
        SampleData(user: "jack", age: 13, rate: 2.2),
        SampleData(user: "hue", age: 11, rate: 3.4),
        SampleData(user: "dustin", age: 20, rate: 2.6)
    ]
    
//    var list = PublishSubject<[SampleData]>()
    var list = PublishRelay<[SampleData]>()

    
    func fetchData() {
//        list.onNext(data) // list = data
        list.accept(data)
    }
    
    func filterData(query: String) {
        let result = query != "" ? data.filter { $0.user.contains(query) } : data
//        list.onNext(result)
        list.accept(result)
    }
}

class ReactiveViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel = ReactiveViewModel()

    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableViewDatasource()
        buttonEvent()
        searchBarEvent()
    }
    
    // MARK: - Rx
    
    func tableViewDatasource() {
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element.user): \(element.age)세 \(element.rate)"
            }.disposed(by: disposeBag)
    }
    
    func buttonEvent() {
        resetButton.rx.tap
            .subscribe { _ in
                self.viewModel.fetchData()
            }.disposed(by: disposeBag)
    }
    
    func searchBarEvent() {
        searchBar.rx.text // searchBar에서 text가 변경될 때 이벤트 발생
            .orEmpty // -> 옵셔널 해제
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // 기다리고 호출
            .distinctUntilChanged() // 기다리는 시간 내에 같은 검색어면 호출 X (같은 값을 받지 않음)
            .subscribe { value in
                print(value)
                self.viewModel.filterData(query: value.element ?? "")
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Helper
    
    func setup() {
        navigationItem.titleView = searchBar
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(resetButton)
        resetButton.backgroundColor = .red
        resetButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.trailing.equalTo(-20)
            make.width.height.equalTo(50)
        }
    }
    
}
