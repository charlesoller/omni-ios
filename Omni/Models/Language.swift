//
//  Language.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

struct Language: Codable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}
