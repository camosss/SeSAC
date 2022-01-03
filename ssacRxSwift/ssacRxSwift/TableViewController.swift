//
//  TableViewController.swift
//  ssacRxSwift
//
//  Created by 강호성 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TableViewController: UIViewController {

    // MARK: - Properties
    
    let tableView = UITableView()
    let label = UILabel()
    
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        configureTableViewDataSource()
    }

    // MARK: - Helper
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(label)
        label.backgroundColor = .lightGray
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func configureTableViewDataSource() {
        // bind -> UI 입장에서 subscribe 구현
        viewModel.items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map({ data in
                "\(data)를 클릭했습니다!"
            })
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewModel

class ViewModel {
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
}
