import SwiftUI

struct MovieDetailsView: View {
    let cardNumber: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Movie Title
                HStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                }
                Text("Movie Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Movie Description
                Text("This is a placeholder for the movie description. It gives an overview of the movie's plot and key details.")
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

#Preview {
    MovieDetailsView(cardNumber: 1)
}
