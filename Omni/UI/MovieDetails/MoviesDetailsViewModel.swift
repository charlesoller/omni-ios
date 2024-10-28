//
//  MoviesDetailsViewModel.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

extension MovieDetailsView {
    @Observable class ViewModel {
        let api = MovieResource()
        var movieDetails: MovieDetails?
        var errorMessage: String?
        
        func fetchMovieDetails(id: Int) async {
            do {
                movieDetails = try await api.fetchMovieDetails(id: id)
            } catch {
                print(error.localizedDescription)
                errorMessage = "Failed to fetch movie \(error.localizedDescription)"
            }
        }
    }
}
