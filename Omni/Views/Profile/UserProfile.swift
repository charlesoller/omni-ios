import SwiftUI

struct UserProfileView: View {
    @State private var showMovieReview = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Picture, Name, and Username
                VStack(spacing: 10) {
                    // Profile picture
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))

                    // Name and Username
                    Text("John Doe")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("@johndoe")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)

//                // Follows and Following Stats
//                HStack(spacing: 40) {
//                    VStack {
//                        Text("120")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        Text("Following")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//
//                    VStack {
//                        Text("200")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        Text("Followers")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                }

                // Recent Likes Carousel
                VStack(alignment: .leading) {
                    Text("Recent Likes")
                        .font(.headline)
                        .padding(.leading, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<5) { _ in
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(10)
                            }
                            .onTapGesture {
                                showMovieReview = true
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.top, 20)
                
                // Recent Likes Carousel
                VStack(alignment: .leading) {
                    Text("Recent Likes")
                        .font(.headline)
                        .padding(.leading, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<5) { _ in
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(10)
                            }
                            .onTapGesture {
                                showMovieReview = true
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .sheet(isPresented: $showMovieReview) {
            ReviewView()
        }
    }
}

#Preview {
    UserProfileView()
}
