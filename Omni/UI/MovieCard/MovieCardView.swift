//
//  MovieCardView.swift
//  Omni
//
//  Created by Charles Oller on 10/24/24.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        let imageURL = "https://image.tmdb.org/t/p/original\(movie.posterPath)"
        
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 300, height: 500)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 600)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            case .failure:
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 300, height: 500)
                    .cornerRadius(20)
                    .overlay(
                        Text("Failed to load image")
                            .font(.headline)
                            .foregroundColor(.white)
                    )
                    .shadow(radius: 5)
            @unknown default:
                EmptyView()
            }
        }
    }
}


//#Preview {
//    MovieCardView()
//}
