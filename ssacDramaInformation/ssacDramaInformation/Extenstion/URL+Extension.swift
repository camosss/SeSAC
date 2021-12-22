//
//  URL+Extension.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/23.
//

import Foundation

extension URL {
    static func searchTvShowsURL() -> URL {
        return URL(string: "https://api.themoviedb.org/3/search/tv?api_key=41228218ab5d729f608f18f42b7cf848&language=en-US&query=1")!
    }
    
    static func detailURL(id: String) -> URL {
        return URL(string: "https://api.themoviedb.org/3/tv/\(id)?api_key=41228218ab5d729f608f18f42b7cf848&language=en-US")!
    }
}
