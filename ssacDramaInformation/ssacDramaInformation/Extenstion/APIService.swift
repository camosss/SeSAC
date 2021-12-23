//
//  APIService.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/23.
//

import Foundation

// MARK: - APIError

enum APIError: String, Error {
    case unknownError = "error_unknown"
    case serverError = "error_server"
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

// MARK: - APIService

class APIService {
    func requestData<T: Codable>(url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(.unknownError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError)); return
            }
            
            if let data = data, let result = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(result))
                return
            }
        }.resume()
    }
}
