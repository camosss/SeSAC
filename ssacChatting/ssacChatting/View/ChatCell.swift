//
//  ChatCell.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/13.
//

import UIKit
import SnapKit

class ChatCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ChatCell"
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 32/2
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = true
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "Some Message"
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.bottom.equalTo(4)
            make.width.height.equalTo(32)
        }
        
        addSubview(bubbleContainer)
        bubbleContainer.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.top.bottom.equalToSuperview()
            make.width.lessThanOrEqualTo(250)
        }

        bubbleContainer.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.bottom.equalTo(-4)
        }
    }
    
}
