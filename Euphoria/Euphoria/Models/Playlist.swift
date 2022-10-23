//
//  Playlist.swift
//  Euphoria
//
//  Created by Nikita  on 23.10.2022.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [GenericImage]
    let name: String
    let owner: Owner
}

