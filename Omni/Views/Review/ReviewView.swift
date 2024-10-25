import SwiftUI

struct ReviewView: View {
    @State private var rating = 0 // To track the selected rating
    @State private var reviewText = "" // To track the user's review text

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                // Movie Poster (gray rectangle placeholder)
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)

                // Star Rating System
                HStack {
                    ForEach(1..<6) { star in
                        Image(systemName: star <= rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(star <= rating ? .yellow : .gray)
                            .onTapGesture {
                                rating = star
                            }
                    }
                }
            }

            // Text box for writing a review
            TextEditor(text: $reviewText)
                .frame(maxHeight: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                .padding(.horizontal)

            // Submit Button
            Button(action: {
                // Handle the submit action
                print("Review Submitted: \(reviewText), Rating: \(rating) stars")
            }) {
                Text("Submit")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    ReviewView()
}
