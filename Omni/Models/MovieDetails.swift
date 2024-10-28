//
//  MovieDetails.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

struct MovieDetails: Identifiable, Codable {
    var id: Int32
    var title: String
    var overview: String
    var backdropPath: String
    var budget: Int64
    var popularity: Double
    var posterPath: String
    var releaseDate: String  // We'll keep as String for now
    var revenue: Int64
    var runtime: Int32
    var voteAverage: Double
    var voteCount: Int32
    var status: String
    var collectionName: String
    var collectionPosterPath: String
    var castMembers: [CastMember]?
    var crewMembers: [CrewMember]?
    var genres: [Genre]?
    var countries: [Country]?
    var languages: [Language]?
    var productionCompanies: [ProductionCompany]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case budget
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case status
        case collectionName = "collection_name"
        case collectionPosterPath = "collection_poster_path"
        case castMembers = "cast_members"
        case crewMembers = "crew_members"
        case genres
        case countries
        case languages
        case productionCompanies = "production_companies"
    }
}
