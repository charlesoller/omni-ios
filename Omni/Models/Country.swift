//
//  Country.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

struct Country: Codable {
    let iso31661: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}
