import Foundation

extension SwiperView {
    @Observable class ViewModel {
        let api = MovieResource()
        let embeddingService = EmbeddingService()
        var userData: UserData?
        var seen: [Int32] = []
        
        var movies: [Movie] = []
        var errorMessage: String?
        var scaleEffect: CGFloat = 1.0
        var offset = CGSize.zero
        var rotation: Double = 0
        var isSwiped = false
        
        var showMovieDetails = false
        var selectedCard: Int? = nil
        
        func getNextMovie() async {
            let isAllZeros = userData?.embedding.allSatisfy{ $0 == 0.0 } ?? true
            if (isAllZeros) {
                await fetchMovie(id: 11)
            } else {
                await getSimilarMovies()
            }
        }
        
        func updateEmbedding(reaction: Reaction) async {
            let embedding = movies[0].embedding
            let isAllZeros = userData?.embedding.allSatisfy{ $0 == 0.0 } ?? true
            if (isAllZeros) {
                userData?.embedding = embedding
            } else {
                if (reaction == Reaction.like) {
                    userData?.embedding = embeddingService.moveTo(userEmbedding: userData!.embedding, likedEmbedding: embedding)!
                } else {
                    userData?.embedding = embeddingService.moveAway(userEmbedding: userData!.embedding, dislikedEmbedding: embedding)!
                }
            }
        }
        
        func fetchMovie(id: Int) async {
            do {
                let movie = try await api.fetchMovie(id: id)
                movies = [movie]
            } catch {
                errorMessage = "Failed to fetch movie \(error.localizedDescription)"
            }
        }
        
        func fetchMovies() async {
            do {
                movies = try await api.fetchMovies()
            } catch {
                errorMessage = "Failed to load movies: \(error.localizedDescription)"
            }
        }
        
        func getSimilarMovies() async {
            seen.append(movies[0].id)
            do {
                let found = try await api.getSimilarMovies(embedding: userData!.embedding)
                let filtered = found.filter { !seen.contains($0.id) }
                movies = [filtered[0]]
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
        enum Reaction {
            case like, dislike
        }
    }
}
