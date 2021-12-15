//
//  SquareBoxView.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/13.
//

import UIKit

class SquareBoxView: TabAninationView {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        loadUI()
    }
    
    // MARK: - Helper
    
    func loadView() {
        let view = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        self.addSubview(view)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "마이페이지"
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemOrange
    }
}

// MARK: - UIButton 클릭 시, 애니메이션

class TabAninationView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
}
