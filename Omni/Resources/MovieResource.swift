//
//  MovieResource.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

struct MovieResource: APIResource {
    typealias ModelType = Movie
    let methodPath = "/movies"
    let api: APIClient

    init(api: APIClient = NetworkManager()) {
        self.api = api
    }
    
    func fetchMovies() async throws -> [Movie] {
        return try await api.get(url: self.url)
    }
}
