//
//  ViewController.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .white
//        favoriteMenuView.label.text = "즐겨찾기"
//        favoriteMenuView.imageView.image = UIImage(systemName: "star")
    }

    // MARK: - Helper
    
    func configureView() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        blueView.backgroundColor = .blue
        
        redView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        greenView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }

    // MARK: - Action
    
    @IBAction func presentButtonClicked(_ sender: UIButton) {
        present(DetailViewController(), animated: true, completion: nil)
    }
}

