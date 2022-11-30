//
//  LibraryAlbumResponse.swift
//  Euphoria
//
//  Created by macbook on 30.11.2022.
//

import Foundation

struct LibraryAlbumResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
