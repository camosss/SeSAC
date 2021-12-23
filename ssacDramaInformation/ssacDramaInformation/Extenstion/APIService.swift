//
//  APIService.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/23.
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
    func requestData(completion: @escaping (TvShows?) -> Void) {
        URLSession.shared.dataTask(with: URL.searchTvShowsURL()) { data, response, error in
            if let error = error {
                self.showAlert(.unknownError)
                print(error); return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError); return
            }

            if let data = data, let TvData = try? JSONDecoder().decode(TvShows.self, from: data) {
                completion(TvData)
                return
            }
            completion(nil)
            
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
        // error 알림
    }
}
