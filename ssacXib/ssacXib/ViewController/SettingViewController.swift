//
//  SettingViewController.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/15.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String?
    
    let firstSquareView: SquareBoxView = {
        let squareBox = SquareBoxView()
        squareBox.label.text = "뱅크"
        squareBox.imageView.image = UIImage(systemName: "star")
        return squareBox
    }()
    
    let secondSquareView: SquareBoxView = {
        let squareBox = SquareBoxView()
        squareBox.label.text = "증권"
        squareBox.imageView.image = UIImage(systemName: "star.fill")
        return squareBox
    }()
    
    let thirdSquareView: SquareBoxView = {
        let squareBox = SquareBoxView()
        squareBox.label.text = "고객센터"
        squareBox.imageView.image = UIImage(systemName: "person")
        return squareBox
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        showAnimate()
    }
    
    // MARK: - Helper
    
    func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [firstSquareView, secondSquareView, thirdSquareView])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(80)
        }
    }
    
    func showAnimate() {
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.firstSquareView.alpha = 1
        } completion: { bol in
            UIView.animate(withDuration: 0.5) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 0.5) {
                    self.thirdSquareView.alpha = 1
                }
            }
        }
    }
}
