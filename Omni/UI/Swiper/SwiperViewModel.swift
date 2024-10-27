import Foundation

extension SwiperView {
    
    @Observable class ViewModel {
        let api = MovieResource()
        var movies: [Movie] = []
        var errorMessage: String?
        var scaleEffect: CGFloat = 1.0
        var offset = CGSize.zero
        var rotation: Double = 0
        var isSwiped = false
        
        var showMovieDetails = false
        var selectedCard: Int? = nil
        
        func fetchMovies() async {
            do {
                movies = try await api.fetchMovies()
            } catch {
                errorMessage = "Failed to load movies: \(error.localizedDescription)"
            }
        }
        
        func isTopCard(movie: Movie) -> Bool {
            return movie.id == movies.first?.id
        }
        
        func swipeCard(to direction: SwipeDirection) {
            switch direction {
            case .left:
                offset = CGSize(width: -1000, height: 0)
            case .right:
                offset = CGSize(width: 1000, height: 0)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let firstCard = self.movies.removeFirst()
                self.movies.append(firstCard)
                self.resetCard()
            }
            
            isSwiped = true
        }
        
        func resetCard() {
            offset = .zero
            rotation = 0
        }
        
        enum SwipeDirection {
            case left, right
        }
    }
}
