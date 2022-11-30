//
//  LibraryPlaylistResponse.swift
//  Euphoria
//
//  Created by macbook on 29.11.2022.
//

import Foundation

struct LibraryPlaylistResponse: Codable {
    let href: String
    let items: [Playlist]
    let total: Int
}
