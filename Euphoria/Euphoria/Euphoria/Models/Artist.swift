//
//  Artist.swift
//  Euphoria
//
//  Created by macbook on 26.11.2022.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String : String]
    let images: [GenericImage]?
    let genres: [String]?
}
