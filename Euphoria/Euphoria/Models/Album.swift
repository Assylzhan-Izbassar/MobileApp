//
//  Albun.swift
//  Euphoria
//
//  Created by Nikita  on 09.10.2022.
//

import Foundation

// Get a list of new ALBUM releases
struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
//    var songs: [Song]
    
    let artists: [Artist]
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [GenericImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let external_urls: [String: String]
}

extension Album {
    static func getAlbums() -> [Album] {
//        return [
//            Album(name: "For training", songs: [
//                Song(name: "Bowie", artistName: "Art of war", posterUrl: "artofwar", fileName: "Bowie-ArtofWar")
//            ]),
//            Album(name: "For study", songs: [
//            ]),
//            Album(name: "Sadly", songs: [
//            ]),
//            Album(name: "Dance", songs: [
//            ])
//        ]
        return []
    }
}
