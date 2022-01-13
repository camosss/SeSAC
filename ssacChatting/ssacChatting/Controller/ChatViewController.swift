//
//  ChatViewController.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/13.
//

import UIKit

class ChatViewController: UICollectionViewController {

    // MARK: - Properties
    
    private lazy var chatInputView: ChatInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = ChatInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureChatInputView()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        navigationItem.title = "메세지"
        collectionView.backgroundColor = .white
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        collectionView.alwaysBounceVertical = true // 수직
        collectionView.keyboardDismissMode = .interactive
    }
    
    func configureChatInputView() {
        view.addSubview(chatInputView)
        chatInputView.messageTextView.delegate = self
        chatInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ChatViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 30, right: 0)
    }
}

// MARK: - ChatInputAccesoryViewDelegate

extension ChatViewController: ChatInputAccesoryViewDelegate {
    func inputView(_ inputView: ChatInputAccesoryView, wantsToUploadMessage message: String) {
        print("send message \(message)")
    }
}

// MARK: - UITextViewDelegate

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("textView.text \(textView.text ?? "")")
    }
}
