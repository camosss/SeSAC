//
//  ChatInputAccesoryView.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/13.
//

import UIKit

protocol ChatInputAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: ChatInputAccesoryView, wantsToUploadMessage message: String)
}

class ChatInputAccesoryView: UIView {

    // MARK: - Properties
    
    weak var delegate: ChatInputAccesoryViewDelegate?
    
    let messageTextView: InputTextView = {
       let tv = InputTextView()
        tv.placeholderText = "메세지 보내기.."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isScrollEnabled = true
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("보내기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
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
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Action
    
    @objc func handlePostTapped() {
        delegate?.inputView(self, wantsToUploadMessage: messageTextView.text)
    }
    
    // MARK: - Helper

    func clearCommentTextView() {
        messageTextView.text = nil
        messageTextView.placeholderLabel.isHidden = false
    }
    
    func configureUI() {
        backgroundColor = .white
        autoresizingMask = .flexibleHeight

        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(messageTextView)
        messageTextView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.leading.equalTo(15)
            make.trailing.equalTo(-65)
            make.bottom.equalTo(-35)
        }
        
        addSubview(postButton)
        postButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.width.height.equalTo(55)
        }
    }
    
}
