import SwiftUI

struct SwiperView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = MovieViewModel()

    @State private var scaleEffect: CGFloat = 1.0
    @State private var offset = CGSize.zero
    @State private var rotation: Double = 0
    @State private var isSwiped = false
    
    @State private var showMovieDetails = false
    @State private var selectedCard: Int? = nil

    var body: some View {
        VStack {
            ZStack {
                ForEach(viewModel.movies, id: \.id) { movie in
                    MovieCardView(movie: movie) // Update to use Movie object
                        .scaleEffect(isTopCard(movie: movie) ? scaleEffect : 1.0)
                        .offset(x: isTopCard(movie: movie) ? offset.width : 0, y: isTopCard(movie: movie) ? offset.height : 0)
                        .rotationEffect(isTopCard(movie: movie) ? .degrees(rotation) : .zero)
                        .scaleEffect(isTopCard(movie: movie) ? 1.0 : 0.95)
                        .opacity(isTopCard(movie: movie) ? 1.0 : 0.5)
                        .zIndex(isTopCard(movie: movie) ? 1 : 0)
                        .gesture(
                            LongPressGesture(minimumDuration: 1.0)
                                .onEnded { _ in
                                    if isTopCard(movie: movie) {
                                        selectedCard = Int(movie.id)
                                        showMovieDetails = true
                                    }
                                }
                                .simultaneously(with:
                                    DragGesture()
                                        .onChanged { gesture in
                                            if isTopCard(movie: movie) {
                                                scaleEffect = 1.05
                                                offset = gesture.translation
                                                rotation = Double(gesture.translation.width / 20)
                                            }
                                        }
                                        .onEnded { gesture in
                                            if isTopCard(movie: movie) {
                                                scaleEffect = 1
                                                if abs(gesture.translation.width) > 100 {
                                                    if gesture.translation.width > 0 {
                                                        swipeCard(to: .right)
                                                    } else {
                                                        swipeCard(to: .left)
                                                    }
                                                } else {
                                                    resetCard()
                                                }
                                            }
                                        }
                                )
                        )
                        .animation(.default, value: offset)
                }
            }
        }
        .sheet(isPresented: $showMovieDetails) {
            MovieDetailsView(movie: viewModel.movies[0])
        }
        .onAppear {
            viewModel.fetchMovies()
        }
    }
    
    private func isTopCard(movie: Movie) -> Bool {
        return movie.id == viewModel.movies.first?.id
    }
    
    func swipeCard(to direction: SwipeDirection) {
        switch direction {
        case .left:
            offset = CGSize(width: -1000, height: 0)
        case .right:
            offset = CGSize(width: 1000, height: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let firstCard = viewModel.movies.removeFirst()
            viewModel.movies.append(firstCard)
            resetCard()
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

// Preview
#Preview {
    SwiperView()
}
