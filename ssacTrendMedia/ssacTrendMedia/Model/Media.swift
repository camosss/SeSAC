//
//  Media.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/28.
//

import Foundation

struct Media {
    let id: Int
    let mediaType: String
    let title: String
    let voteAverage: String
    let releaseDate: String
    let overView: String
    let posterImage: String
    let backDropImage: String
}

struct Cast {
    let name: String
    let character: String
    let profileImage: String
}

struct Crew {
    let originalName: String
    let job: String
    let profileImage: String
}
