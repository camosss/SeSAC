//
//  DetailViewController.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let bannerView = BannerView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        
        bannerView.frame = CGRect(x: 30, y: 100,
                                  width: UIScreen.main.bounds.width-60,
                                  height: 120)
        bannerView.backgroundColor = .white
        view.addSubview(bannerView)
    }
}
