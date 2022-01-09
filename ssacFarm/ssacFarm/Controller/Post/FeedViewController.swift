//
//  FeedViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    let tk = TokenUtils()
    let viewModel = PostAPIViewModel()
    let refreshControl = UIRefreshControl()
    
    private var posts = [Post]() {
        didSet { self.collectionView.reloadData() }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 70/2
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(myProfileSetting))

        configureCollectionView()
        configureActionButton()
        configureLeftTitle(title: "새싹농장 🌱")
        initRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populatePostData()
    }
    
    // MARK: - Action
    
    @objc func myProfileSetting() {
        AlertHelper.actionSheetAlert(first: "비밀번호 변경", second: "로그아웃", onFirst: {
            let controller = ChangePasswordViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }, onSecond: {
            self.handleLogout()
        }, over: self)
    }
    
    @objc func actionButtonTapped() {
        let controller = UploadPostViewController()
        controller.navigationTitle = "새싹농장 글쓰기"
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.populatePostData()
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Helper
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.right.equalTo(-20)
            make.width.height.equalTo(70)
        }
        actionButton.layer.shadowOpacity = 0.5
        actionButton.layer.shadowRadius = 70/2
        actionButton.layer.shadowOffset = .init(width: 0, height: -5)
        actionButton.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func returnStartPage() {
        let nav = UINavigationController(rootViewController: StartViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    func handleLogout() {
        self.tk.delete("\(Endpoint.auth_register.url)", account: "token")
        returnStartPage()
    }
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .systemGreen
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침 🌱", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        collectionView.refreshControl = refreshControl
    }
    
    // MARK: - Helper(Network)

    func populatePostData() {
        let token = tk.load("\(Endpoint.auth_register.url)", account: "token") ?? ""
        print("load \(token)")
        viewModel.getPostData(token: token) { posts, error in
            if let error = error {
                print("error \(error)")
                if error == .invaildToken {
                    self.returnStartPage()
                }
                return
            }

            if let posts = posts {
                DispatchQueue.main.async {
                    self.posts = posts
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath) as! FeedCollectionViewCell
        cell.backgroundColor = .white
        cell.delegate = self
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedDetailViewController()
        controller.post = posts[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFloowlayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = PostViewModel(post: posts[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 140)
    }
}

// MARK: - FeedCollectionViewCellDelegate

extension FeedViewController: FeedCollectionViewCellDelegate {
    func cell(_ cell: FeedCollectionViewCell) {
        print("comment")
    }
}
