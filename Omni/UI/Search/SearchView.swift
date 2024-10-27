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
            .task {
                await viewModel.fetchMovies()
            }
        }
    }
}

struct GridView: View {
    let movies: [Movie]
    let onSelect: (Movie) -> Void
    @State private var showMovieDetails = false

    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 120))
        ]
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(movies, id: \.id) { movie in
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 180)
                        .cornerRadius(10)
                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.top, 5)
                }
                .onTapGesture {
                    showMovieDetails = true
                }
            }
        }
        .padding()
        .sheet(isPresented: $showMovieDetails) {
            MovieDetailsView(movie: movies[0])
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
