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
    let percentLabel = UILabel()
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = (Double(buffer?.count ?? 0) / total)*100
            percentLabel.text = "\(result)/100.0"
        }
    }
    
    var session: URLSession! // 강한 참조 (resource 정리작업 필요)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        
        // buffer가 옵셔널인 상태로 선언되어있고 nil이기 때문에,
        // 이후에 append 메서드가 실행되지 않아 초기화 (nil이 되지 않도록)
        buffer = Data() // 0 byte
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        session.finishTasksAndInvalidate() // task가 끝난 뒤, resource 정리
//        session.invalidateAndCancel() // resource 정리 (실행준인 task가 있더라도 stop)
    }
    
    override func configureUI() {
        imageView.backgroundColor = .magenta
        imageView.contentMode = .scaleAspectFill
        
        percentLabel.textAlignment = .center
        percentLabel.backgroundColor = .white
        percentLabel.textColor = .black
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    // MARK: - Helper
    
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_2980.jpg")!
        
        // shared: Delegate 호출 X
//        URLSession.shared.dataTask(with: url).resume()
        
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = false
//        URLSession(configuration: configuration).dataTask(with: url).resume()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()
        
    }
}

// MARK: - URLSessionDelegate

extension NASAViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답을 받은 경우 호출 (상태코드 분기처리)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(response)
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            // header에서 "Content-Length"을 추출하여 퍼센트 계산
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            
            return .allow
        } else {
            return .cancel
        }
        
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        print(data)
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let error = error {
            print("오류가 발생했습니다", error)
        } else {
            print("성공")
            
            // buffer에 Data가 모두 채워졌을 때, 이미지로 변환
            guard let buffer = buffer else {
                print("buffer error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }

}
