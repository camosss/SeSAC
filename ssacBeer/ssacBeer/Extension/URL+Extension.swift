//
//  URL+Extension.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/21.
//

import Foundation

extension URL {
    static func randomURL() -> URL {
        return URL(string: "https://api.punkapi.com/v2/beers/random")!
    }
}
