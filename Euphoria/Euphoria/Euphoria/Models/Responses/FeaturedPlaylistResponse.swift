//
//  FeaturedPlaylistResponse.swift
//  Euphoria
//
//  Created by macbook on 26.11.2022.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}
