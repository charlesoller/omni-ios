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
    
    func fetchMovie(id: Int) async throws -> Movie {
        let url = self.url
            .appendingPathComponent("\(id)")
        return try await api.get(url: url)
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        let url = self.url
            .appendingPathComponent("\(id)")
            .appendingPathComponent("details")

        return try await api.get(url: url)
    }
    
    func getSimilarMovies(embedding: [Float]) async throws -> [Movie] {
        let url = self.url
            .appendingPathComponent("embeddings")
            .appendingPathComponent("search")
        
        return try await api.post(url: url, body: embedding)
    }
}
