//
//  TheaterOptions.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/21.
//

import Foundation

enum TheaterOptions: Int, CaseIterable {
    case lotteCinema
    case megaBox
    case cgv
    
    var description: String {
        switch self {
        case .lotteCinema: return "롯데시네마"
        case .megaBox: return "메가박스"
        case .cgv: return "CGV"
        }
    }
}
