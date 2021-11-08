//
//  HomeViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        title = LocalizableStrings.home.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

        tabBarController?.tabBar.items![0].title = LocalizableStrings.home.localized
        tabBarController?.tabBar.items![1].title = LocalizableStrings.search.localized
        tabBarController?.tabBar.items![2].title = LocalizableStrings.calendar.localized
        tabBarController?.tabBar.items![3].title = LocalizableStrings.setting.localized
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.categoryLabel.backgroundColor = .lightGray
        cell.collectionView.backgroundColor = .lightGray
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        
        cell.collectionView.tag = indexPath.row
        cell.collectionView.isPagingEnabled = true
        return cell
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        cell.imageView.backgroundColor = .systemGreen
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
        return CGSize(width: 150, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
    }
}
