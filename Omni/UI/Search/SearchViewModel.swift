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
        var selectedMovie: Movie?
        var searchText: String = "" {
            didSet {
                Task { await searchMovies() }
            }
        }
        
        func searchMovies() async {
            guard !searchText.isEmpty else {
                movies = []
                return
            }
            
            do {
                movies = try await api.searchMovies(title: searchText)
            } catch {
                errorMessage = "Failed to search movies: \(error.localizedDescription)"
            }
        }
    }
}
