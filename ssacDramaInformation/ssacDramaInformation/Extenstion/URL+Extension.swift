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
        return URL(string: "\(baseURL)/search/tv?api_key=\(APIKEY().apikey)&language=ko-KR&query=\(text)&region=ko-KR")!
    }
    
    static func detailURL(id: Int) -> URL {
        return URL(string: "\(baseURL)/tv/\(id)?api_key=\(APIKEY().apikey)&language=ko-KR")!
    }
}

// https://api.themoviedb.org/3/search/person?api_key=41228218ab5d729f608f18f42b7cf848&language=en-US&query=%ED%98%84%EB%B9%88&page=1&include_adult=false&region=ko-KR
