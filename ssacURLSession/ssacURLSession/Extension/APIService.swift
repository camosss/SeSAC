//
//  APIService.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import Foundation

// MARK: - APIError

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

// MARK: - APIService

class APIService {
    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    func requestCast(completion: @escaping (Cast?) -> Void) {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
            if let error = error {
                self.showAlert(.unknownError)
                print(error); return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError); return
            }

            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                print("Succeed", castData)
                completion(castData)
                return
            }
            completion(nil)
            
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
        // error 알림
    }
}
