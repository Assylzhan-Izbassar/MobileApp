//
//  Song.swift
//  Euphoria
//
//  Created by macbook on 14.11.2022.
//

import Foundation

struct Track: Codable {
    var album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String:String]
    let id: String
    let name: String
    let track_number: Int?
    let popularity: Int?
    let type: String?
    let preview_url: String?
}

struct TracksResponse: Codable {
    let items: [Track]
    let total: Int
}

struct Song: Codable {
    var name: String
    var artistName: String
    var posterUrl: String
    var fileName: String
}
