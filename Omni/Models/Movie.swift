import Foundation

struct Movie: Identifiable, Codable {
    var id: Int32
    var title: String
    var originalTitle: String
    var overview: String
    var releaseDate: String
    var runtime: Int32
    var budget: Int64
    var revenue: Int64
    var popularity: Double
    var voteAverage: Double
    var voteCount: Int32
    var status: String
    var tagline: String
    var homepage: String
    var originalLanguage: String
    var adult: Bool
    var backdropPath: String
    var posterPath: String
    var collectionID: Int32?
    var embedding: [Float]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case runtime
        case budget
        case revenue
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case status
        case tagline
        case homepage
        case originalLanguage = "original_language"
        case adult
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case collectionID = "collection_id"
        case embedding
    }
}
