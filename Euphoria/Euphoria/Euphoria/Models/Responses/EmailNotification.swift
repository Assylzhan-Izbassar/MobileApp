//
//  EmailNotification.swift
//  Euphoria
//
//  Created by Nikita  on 22.12.2022.
//

import Foundation

struct EmailNotification: Codable {
    let recipient: String
    let subject: String
    let content: String
}
