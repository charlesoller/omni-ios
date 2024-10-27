import SwiftUI

struct SwiperView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userData: UserData

    @State private var viewModel = ViewModel()
    
    var body: some View {

        VStack {
            ZStack {
                ForEach(viewModel.movies, id: \.id) { movie in
                    MovieCardView(movie: movie) // Update to use Movie object
                        .scaleEffect(viewModel.isTopCard(movie: movie) ? viewModel.scaleEffect : 1.0)
                        .offset(x: viewModel.isTopCard(movie: movie) ? viewModel.offset.width : 0, y: viewModel.isTopCard(movie: movie) ? viewModel.offset.height : 0)
                        .rotationEffect(viewModel.isTopCard(movie: movie) ? .degrees(viewModel.rotation) : .zero)
                        .scaleEffect(viewModel.isTopCard(movie: movie) ? 1.0 : 0.95)
                        .opacity(viewModel.isTopCard(movie: movie) ? 1.0 : 0.5)
                        .zIndex(viewModel.isTopCard(movie: movie) ? 1 : 0)
                        .gesture(
                            LongPressGesture(minimumDuration: 1.0)
                                .onEnded { _ in
                                    if viewModel.isTopCard(movie: movie) {
                                        viewModel.selectedCard = Int(movie.id)
                                        viewModel.showMovieDetails = true
                                    }
                                }
                                .simultaneously(with:
                                    DragGesture()
                                        .onChanged { gesture in
                                            if viewModel.isTopCard(movie: movie) {
                                                viewModel.scaleEffect = 1.05
                                                viewModel.offset = gesture.translation
                                                viewModel.rotation = Double(gesture.translation.width / 20)
                                            }
                                        }
                                        .onEnded { gesture in
                                            if viewModel.isTopCard(movie: movie) {
                                                viewModel.scaleEffect = 1
                                                if abs(gesture.translation.width) > 100 {
                                                    if gesture.translation.width > 0 {
                                                        viewModel.swipeCard(to: .right)
                                                    } else {
                                                        viewModel.swipeCard(to: .left)
                                                    }
                                                } else {
                                                    viewModel.resetCard()
                                                }
                                            }
                                        }
                                )
                        )
                        .animation(.default, value: viewModel.offset)
                }
            }
        }

        .sheet(isPresented: $viewModel.showMovieDetails) {
            MovieDetailsView(movie: viewModel.movies[0])
        }
        .task {
            await viewModel.getNextMovie()
        }
        .onAppear {
            viewModel.userData = userData
        }
    }

}

#Preview {
    ContentView()
}
