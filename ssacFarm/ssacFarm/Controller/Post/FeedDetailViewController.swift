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
    
    var comments = [CommentElement]() {
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
        configureUI()
        populateCommentData()
        checkPostOwner()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Action
    
    @objc func editButtonTapped() {
        AlertHelper.actionSheetAlert(first: "편집", second: "삭제", onFirst: {
            let controller = UploadPostViewController()
            
            self.passData(controller: controller, navigationTitle: "게시물 수정하기", isUpdated: "post", content: self.post?.text ?? "", commentId: 0, postId: self.post?.id ?? 0)
            
        }, onSecond: {
            self.DeletePost(id: self.post?.id ?? 0)
            
        }, over: self)
    }
    
    // MARK: - Helper
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(editButtonTapped))

        view.addSubview(collectionView)
        view.addSubview(commentInputView)
        commentInputView.commentTextView.delegate = self
        commentInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    func checkPostOwner() {
        let id = self.tk.load("\(Endpoint.auth_register.url)", account: "id") ?? ""
        let postOwnerId = "\(self.post?.user.id ?? 0)"
        
        if id != postOwnerId {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func passData(controller: UploadPostViewController, navigationTitle: String, isUpdated: String, content: String, commentId: Int, postId: Int) {
        controller.navigationTitle = navigationTitle
        controller.isUpdated = isUpdated
        controller.content = content
        controller.commentId = commentId
        controller.postId = postId
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    // MARK: - Helper(Network)
    
    func populateCommentData() {
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? ""

        APIService.commentInquire(token: token, postId: post?.id ?? 0) { comments, error in
            if let error = error {
                print("fetch comment \(error)")
                return
            }
            
            if let comments = comments {
                self.comments = comments.sorted(by: { $0.updatedAt > $1.updatedAt })
            }
        }
    }
    
    func DeletePost(id: Int) {
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? "no token"

        AlertHelper.confirmAlert(title: "게시물을 삭제하시겠어요?", message: "", okMessage: "삭제", onConfirm: {
            APIService.postDelete(id: id, token: token) { _, _ in
                self.navigationController?.popViewController(animated: true)
            }
        }, over: self)
    }

    func DeleteComment(id: Int) {
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? "no token"

        AlertHelper.confirmAlert(title: "댓글을 삭제하시겠어요?", message: "", okMessage: "삭제", onConfirm: {
            APIService.commentDelete(id: id, token: token) { _, _ in
                print("댓글 삭제 완료")
            }
        }, over: self)
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FeedDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath) as! FeedDetailCollectionViewCell
        cell.backgroundColor = .white
        cell.delegate = self
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
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
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 80)
    }
}

// MARK: - CommentInputAccesoryViewDelegate

extension FeedDetailViewController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? ""

        APIService.commentWrite(token: token, postId: post?.id ?? 0, comment: comment) { comment, error in
            if let error = error {
                print("comment write \(error)")
                return
            }
        }
        commentInputView.clearCommentTextView()
        self.populateCommentData()
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

// MARK: - FeedDetailCollectionViewCellDelegate

extension FeedDetailViewController: FeedDetailCollectionViewCellDelegate {
    func cell(_ cell: FeedDetailCollectionViewCell) {
        AlertHelper.actionSheetAlert(first: "편집", second: "삭제", onFirst: {
            let controller = UploadPostViewController()
            
            self.passData(controller: controller, navigationTitle: "댓글 수정하기", isUpdated: "comment", content: cell.viewModel?.text ?? "", commentId: cell.viewModel?.comment.id ?? 0, postId: cell.viewModel?.comment.post.id ?? 0)
            
        }, onSecond: {
            self.DeleteComment(id: cell.viewModel?.comment.id ?? 0)
            
        }, over: self)
    }
}

