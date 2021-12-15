//
//  SquareBoxView.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/13.
//

import UIKit

class SquareBoxView: UIView {
    
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
