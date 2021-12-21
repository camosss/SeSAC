//
//  ViewController.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    private let widthSize = UIScreen.main.bounds.width
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shoes")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let bottomView = UIView()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise")!, for: .normal)
        button.tintColor = .systemMint
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemMint.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTaprefreshButton), for: .touchUpInside)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share BEER", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.tintColor = .black
        button.backgroundColor = .systemMint.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapshareButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureBottomUI()
        view.addSubview(imageView)
    }
    
    // MARK: - Action
    
    @objc func didTaprefreshButton() {
        print("didTaprefreshButton")
    }
    
    @objc func didTapshareButton() {
        print("didTapshareButton")
    }

    // MARK: - Helper

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .magenta
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.contentInset.top = 300
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    // 스크롤 할때마다 계속 호출
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 500)
        imageView.frame = CGRect(x: 0, y: 0, width: widthSize, height: height)
    }
}
