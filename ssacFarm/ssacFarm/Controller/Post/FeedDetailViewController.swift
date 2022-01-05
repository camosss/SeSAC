//
//  FeedDetailViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    // MARK: - Properties

    let tk = TokenUtils()

    var viewModel = ButtonViewModel()
    
    var post: Post? {
        didSet { self.collectionView.reloadData() }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.contentInset.bottom = 100
        
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.register(FeedDetailCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
        collectionView.register(FeedDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FeedDetailHeaderView.identifer)
        return collectionView
    }()
    
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        configureNavigationBar()
        
        view.addSubview(commentInputView)
        commentInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        commentInputView.commentTextView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Action
    
    @objc func editButtonTapped() {
        AlertHelper.actionSheetAlert(onEdit: {
            let controller = UploadPostViewController()
            controller.navigationTitle = "편집하기"
            
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }, onDelete: {
            AlertHelper.confirmAlert(title: "게시물을 삭제하시겠어요?", message: "", okMessage: "삭제", onConfirm: {
                print("삭제")
            }, over: self)
        }, over: self)
    }
    
    // MARK: - Helper
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FeedDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath) as! FeedDetailCollectionViewCell
        cell.backgroundColor = .systemGray6
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FeedDetailHeaderView.identifer, for: indexPath) as! FeedDetailHeaderView
        header.backgroundColor = .white
        
        if let post = post {
            header.viewModel = PostViewModel(post: post)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let post = post {
            let viewModel = PostViewModel(post: post)
            let height = viewModel.size(forWidth: view.frame.width).height
            return CGSize(width: view.frame.width, height: height + 170)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

// MARK: - CommentInputAccesoryViewDelegate

extension FeedDetailViewController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        print("DEBUG: Comment is \(comment)")
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? ""
        
        APIService.commentWrite(token: token, postId: post?.id ?? 0, comment: comment) { comment, _ in
            if let comment = comment {
                print(comment)
            }
        }
        
        commentInputView.clearCommentTextView()
    }
}

// MARK: - FormViewModel

extension FeedDetailViewController: FormViewModel {
    func updateForm() {
        commentInputView.postButton.isEnabled = viewModel.formIsValid
        commentInputView.postButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}

// MARK: - UITextViewDelegate

extension FeedDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == commentInputView.commentTextView {
            viewModel.content = textView.text
        }
        updateForm()
    }
}
