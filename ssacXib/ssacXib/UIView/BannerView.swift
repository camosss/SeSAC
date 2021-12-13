//
//  BannerView.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/13.
//

import UIKit

class BannerView: UIView {
    
    // MARK: - Properties
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    // MARK: - Lifecycle
    
    // xib로 한다면 필요없음 (코드 기반)
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadLayout()
    }
    
    // 실패 가능한 이니셜라이저
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func loadLayout() {
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textColor = .black
        mainLabel.text = "내일 오를 주식을 맞춰주세요!"
        
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "맞히면 500원을 드려요"
        
        mainLabel.frame = CGRect(x: 30, y: 30,
                                 width: UIScreen.main.bounds.width-130,
                                 height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80,
                                        width: UIScreen.main.bounds.width-130,
                                        height: 30)
        
        self.addSubview(mainLabel)
        self.addSubview(descriptionLabel)
    }
    
}
