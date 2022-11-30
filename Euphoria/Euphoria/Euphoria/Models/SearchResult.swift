//
//  SearchResult.swift
//  Euphoria
//
//  Created by macbook on 30.11.2022.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case track(model: Track)
    case album(model: Album)
}
