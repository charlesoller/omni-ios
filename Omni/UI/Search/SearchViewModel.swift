//
//  SearchViewModel.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

extension SearchView {
    @Observable class ViewModel {
        let api = MovieResource()
        var errorMessage: String?
        var movies: [Movie] = []
        var searchText: String = ""
        var selectedMovie: Movie?
        
        func fetchMovies() async {
            do {
                movies = try await api.fetchMovies()
            } catch {
                errorMessage = "Failed to load movies: \(error.localizedDescription)"
            }
        }
    }
}
