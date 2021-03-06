//
//  ViewController.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/20.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {

    // MARK: - Properties
    
    private var beer = [Beer]()
    
    var isExpend = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(FoodParingTableViewCell.self, forCellReuseIdentifier: FoodParingTableViewCell.identifier)
        return tableView
    }()
    
    let header = StretchyTableHeaderView()
    let sectionHeader = SectionHeaderView()
    let sectionFooter = SectionFooterView()
    
    // MARK: Bottom
    
    private let bottomView = UIView()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise")!, for: .normal)
        button.tintColor = .systemMint
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemMint.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share BEER", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.tintColor = .black
        button.backgroundColor = .systemMint.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        
        configureTableView()
        configureBottomUI()
        configureHeaderFooterView()
    }
    
    // MARK: - Action
    
    @objc func didTapRefreshButton() {
        populateData()
    }
    
    @objc func didTapShareButton() {
        print("didTapshareButton")
    }
    
    // MARK: - API
    
    private func populateData() {
        AF.request(URL.randomURL(), method: .get).validate().responseDecodable(of: [Beer].self) { response in
            self.beer = response.value ?? []
            self.tableView.reloadData()
        }
    }

    // MARK: - Helper

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.contentInset.bottom = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    private func configureHeaderFooterView() {
        header.frame = CGRect(x: 0, y: 0,
                              width: view.frame.size.width,
                              height: view.frame.size.width-200)
        header.imageView.image = UIImage(named: "shoes")
        tableView.tableHeaderView = header
        
        sectionFooter.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 200)
        sectionFooter.titleLabel.text = "sectionFooter"
        sectionFooter.backgroundColor = .systemBlue
        tableView.tableFooterView = sectionFooter
    }
    
    private func configureBottomUI() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        bottomView.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
            make.width.height.equalTo(70)
        }
        
        bottomView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(refreshButton.snp.trailing).offset(10)
            make.trailing.equalTo(-20)
            make.height.equalTo(70)
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? beer.count : beer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
            cell.delegate = self
            cell.beer = beer[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodParingTableViewCell.identifier, for: indexPath) as! FoodParingTableViewCell
            cell.beer = beer[indexPath.row]
            
            var foodPairing = ""
            cell.beer?.foodPairing.forEach({
                foodPairing.append($0)
            })
            
            cell.titleLabel.text = foodPairing
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? (isExpend ? 300 : 200) : 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView(frame: .zero)
        } else {
            sectionHeader.backgroundColor = .green
            return sectionHeader
        }
        
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // 스크롤 할때마다 계속 호출
        guard let header = tableView.tableHeaderView as? StretchyTableHeaderView else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}

// MARK: - DescriptionTableViewCellDelegate

extension ViewController: DescriptionTableViewCellDelegate {
    func cell(_ cell: DescriptionTableViewCell) {
        isExpend.toggle()
        cell.descriptionLabel.numberOfLines = isExpend ? 0 : 3
        self.tableView.reloadData()
    }
}
