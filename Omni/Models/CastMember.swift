//
//  CastMember.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

struct CastMember: Codable {
    let id: Int32
    let castID: Int32?
    let creditID: String?
    let gender: Int16
    let adult: Bool
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Float
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case castID = "cast_id"
        case creditID = "credit_id"
        case gender
        case adult
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
    }
}
