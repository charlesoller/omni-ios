import SwiftUI



struct MovieDetailsView: View {
    let movie: Movie
    @State private var viewModel = ViewModel()

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
                    Text("⭐️ \(String(format: "%.1f", movie.voteAverage))/10")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Text("Cast")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.movieDetails?.castMembers ?? [], id: \.id) { castMember in
                            // Create a Member instance for castMember
                            let member = CastCrew.cast(castMember)
                            CastCrewRow(member: member) // Pass the Member instance
                        }
                    }
                    .padding(.horizontal)
                }
                
                Text("Crew")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.movieDetails?.crewMembers ?? [], id: \.id) { crewMember in
                            // Create a Member instance for castMember
                            let member = CastCrew.crew(crewMember)
                            CastCrewRow(member: member) // Pass the Member instance
                        }
                    }
                    .padding(.horizontal)
                }
                
                
//                // Crew Section
//                Text("Crew")
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                    .padding(.bottom, 5)
//                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 15) {
//                        ForEach(viewModel.movieDetails?.crewMembers ?? [], id: \.id) { crewMember in
//                            CastMemberRow(castMember: crewMember)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
                
            }
            .padding()
        }
        .navigationTitle("Movie Info")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMovieDetails(id: Int(movie.id))
        }
    }
}

#Preview {
    ContentView()
}
