import SwiftUI

struct SearchView: View {
    @State private var viewModel = ViewModel()

    var filteredMovies: [Movie] {
        if viewModel.searchText.isEmpty {
            return []
        }
        return viewModel.movies.filter { $0.title.localizedCaseInsensitiveContains(viewModel.searchText) }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Fixed Header
                VStack {
                    Text("Search")
                        .font(.largeTitle)
                        .padding()

                    TextField("Search movies...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // Scrollable Grid
                ScrollView {
                    if filteredMovies.isEmpty {
                        Text("No results found")
                            .padding()
                    } else {
                        GridView(movies: filteredMovies, onSelect: { movie in
                            viewModel.selectedMovie = movie
                        })
                    }
                }
            }
        }
    }
}

struct GridView: View {
    let movies: [Movie]
    let onSelect: (Movie) -> Void
    @State private var showMovieDetails = false
    @State private var selectedMovie: Movie? // Track selected movie

    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 120))
        ]

        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(movies, id: \.id) { movie in
                VStack {
                    // Check if posterPath is non-empty before loading image
                    if !movie.posterPath.isEmpty,
                       let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath)") {
                        
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 120, height: 180)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(10)
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(10)
                                    .overlay(Text("Image failed to load"))
                            @unknown default:
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        // Show placeholder if posterPath is empty
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 120, height: 180)
                            .cornerRadius(10)
                            .overlay(Text("No Image"))
                    }

                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.top, 5)
                }
                .onTapGesture {
                    selectedMovie = movie
                    showMovieDetails = true
                }
            }
        }
        .padding()
        .sheet(isPresented: $showMovieDetails) {
            if let selectedMovie = selectedMovie {
                MovieDetailsView(movie: selectedMovie)
            }
        }
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
