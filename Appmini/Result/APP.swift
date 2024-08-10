//
//  APP.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import Foundation


struct Music: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let artistName: String?
    let trackName: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
}

