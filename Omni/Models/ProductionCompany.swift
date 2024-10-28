//
//  ProductionCompany.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

struct ProductionCompany: Codable {
    let id: Int32
    let name: String
    let logoPath: String?
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

