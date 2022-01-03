//
//  UploadPostViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

class UploadPostViewController: UIViewController {
    
    // MARK: - Properties
    
    var navigationTitle = ""
    
    private let captionTextView = InputTextView()
    var viewModel = PostViewModel()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("완료", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleUploadPost), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationTitle
        
        configureNavigationBar()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadPost() {
        print("upload \(viewModel.formIsValid)")
    }
    
    // MARK: - Helper
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(captionTextView)
        captionTextView.delegate = self
        captionTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
    }
}

// MARK: - FormViewModel

extension UploadPostViewController: FormViewModel {
    func updateForm() {
        doneButton.isEnabled = viewModel.formIsValid
        doneButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}

// MARK: - UITextViewDelegate

extension UploadPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == captionTextView {
            viewModel.content = textView.text
        }
        updateForm()
    }
}
