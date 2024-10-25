//
//  MovieCardView.swift
//  Omni
//
//  Created by Charles Oller on 10/24/24.
//

import SwiftUI

struct MovieCardView: View {
    let cardNumber: Int
    let imageURL = "https://image.tmdb.org/t/p/original/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg"
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                // Placeholder while the image is loading
                ProgressView()
                    .frame(width: 300, height: 500)
            case .success(let image):
                // Display the loaded image
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 600)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            case .failure:
                // Display an error view if the image fails to load
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
                // Handle unexpected cases
                EmptyView()
            }
        }
    }
}

#Preview {
    MovieCardView(cardNumber: 1)
}
