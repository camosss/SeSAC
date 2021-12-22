//
//  TvShows.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/23.
//

import Foundation

struct TvShows: Codable {
    let results: [TvShow]
}

struct TvShow: Codable {
    let id: Int
    let name: String
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backdropPath = "backdrop_path"
    }
}
