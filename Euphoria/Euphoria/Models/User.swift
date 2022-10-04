//
//  User.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import Foundation

struct User: Codable {
    let id: String
    let country: String
    let display_name: String
    let explicit_content: [String:Bool]
    let explicit_urls: [String:String]
    let product: String
    let image: [GenericImage]?
}

struct Owner: Codable {
    let id: String
    let display_name: String
    let external_urls: [String:String]
}
