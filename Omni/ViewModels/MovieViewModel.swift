import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?

    private let movieService = MovieService()

    func fetchMovies() {
        movieService.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
