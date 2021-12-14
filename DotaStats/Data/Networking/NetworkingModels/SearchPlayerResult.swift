//
//  Search.swift
//  DotaStats
//
//  Created by Igor Efimov on 13.12.2021.
//

import Foundation

struct SearchPlayerResult: Decodable {
    let accountId: Int
    let avatarfull: String?
    let personaname: String?
    let lastMatchTime: Date?
    let similarity: Double?
}
