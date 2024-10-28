import SwiftUI

enum CastCrew {
    case cast(CastMember)
    case crew(CrewMember)
}

struct CastCrewRow: View {
    let member: CastCrew
    private let imageBaseURL = "https://image.tmdb.org/t/p/original"
    
    var body: some View {
        VStack {
            // Determine which member type we're dealing with
            switch member {
            case .cast(let castMember):
                loadImage(for: castMember.profilePath)
                Text(castMember.name)
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
                
            case .crew(let crewMember):
                loadImage(for: crewMember.profilePath)
                Text(crewMember.name)
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
            }
        }
    }
    
    @ViewBuilder
    private func loadImage(for profilePath: String?) -> some View {
        if let profilePath = profilePath,
           let imageURL = URL(string: imageBaseURL + profilePath) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                case .failure:
                    placeholderImage
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            placeholderImage
        }
    }
    
    private var placeholderImage: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .foregroundColor(.gray)
    }
}
