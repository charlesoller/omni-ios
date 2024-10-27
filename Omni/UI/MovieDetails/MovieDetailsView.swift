import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    
    var body: some View {
        let imageURL = "https://image.tmdb.org/t/p/original\(movie.posterPath)"

        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Movie Title
                HStack {
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
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Movie Description
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.gray)
                
                // Movie Rating
                HStack {
                    Text("⭐️ 4.5/5")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                // Cast Section
                Text("Cast")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<10) { _ in
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 80, height: 80)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Crew Section
                Text("Crew")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<10) { _ in
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 80, height: 80)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Movie Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    MovieDetailsView(cardNumber: 1)
//}
