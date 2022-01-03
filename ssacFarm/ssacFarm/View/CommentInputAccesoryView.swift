//
//  CommentInputAccesoryView.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/03.
//

import UIKit

protocol CommentInputAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String)
}

class CommentInputAccesoryView: UIView {

    // MARK: - Properties
    
    weak var delegate: CommentInputAccesoryViewDelegate?
    
    let commentTextView: InputTextView = {
       let tv = InputTextView()
        tv.placeholderText = "댓글을 입력해주세요.."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.backgroundColor = .systemGray6
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("게시", for: .normal)
        button.setTitleColor(.systemGray6, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.isEnabled = false
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
        configureCommentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Action
    
    @objc func handlePostTapped() {
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    // MARK: - Helper

    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }
    
    func configureCommentView() {
        backgroundColor = .white
        autoresizingMask = .flexibleHeight

        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(-35)
        }
        
        addSubview(postButton)
        postButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.width.height.equalTo(55)
        }
    }
    
}
