//
//  NASAViewController.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class NASAViewController: BaseViewController {
    
    // MARK: - Properties
    
    let imageView = UIImageView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }
    
    override func configureUI() {
        imageView.backgroundColor = .magenta
        imageView.contentMode = .scaleAspectFill
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Helper
    
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_2980.jpg")!
        
        // shared: Delegate 호출 X
//        URLSession.shared.dataTask(with: url).resume()
        
        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: url).resume()
        
    }
}

// MARK: - URLSessionDelegate

extension NASAViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답을 받은 경우 호출 (상태코드 분기처리)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            return .allow
        } else {
            return .cancel
        }
        
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let error = error {
            print("오류가 발생했습니다", error)
        } else {
            print("성공")
        }
    }

}
