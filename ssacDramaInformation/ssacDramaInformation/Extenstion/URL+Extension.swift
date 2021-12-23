//
//  URL+Extension.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/23.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3"
    static func searchTvShowsURL(text: String) -> URL {
        return URL(string: "\(baseURL)/search/tv?api_key=\(APIKEY().apikey)&language=ko-KR&query=\(text)")!
    }
    
    static func detailURL(id: String) -> URL {
        return URL(string: "\(baseURL)/tv/\(id)?api_key=\(APIKEY().apikey)&language=en-US")!
    }
}
