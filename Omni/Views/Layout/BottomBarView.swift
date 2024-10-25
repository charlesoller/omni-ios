import SwiftUI

enum BottomBarSelectedTab: Int {
    case home = 0
    case search = 1
    case profile = 3
}

struct BottomBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: BottomBarSelectedTab

    var body: some View {
        HStack(spacing: 0) {
            // Home
            Button {
                selectedTab = .home
            } label: {
                BottomBarButtonView(image: "house.fill", text: "Home", isActive: selectedTab == .home)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            // Search
            Button {
                selectedTab = .search
            } label: {
                BottomBarButtonView(image: "magnifyingglass", text: "Search", isActive: selectedTab == .search)
            }
            .frame(maxWidth: .infinity)
            
            // Profile
            Button {
                selectedTab = .profile
            } label: {
                BottomBarButtonView(image: "person", text: "Profile", isActive: selectedTab == .profile)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 60) // Adjust height as needed
        .padding(.bottom)
        .background(
            Image("bottomBarBG")
                .renderingMode(.template)
                .foregroundColor(Color("PrimaryWhite"))
        )
        .shadow(color: Color("PrimaryBlack").opacity(colorScheme == .dark ? 0.5 : 0.1), radius: 10, x: 0, y: 0)
    }
}

//struct BottomBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBar(selectedTab: .constant(.plus))
//    }
//}

struct BottomBarButtonView: View {
    var image: String
    var text: String
    var isActive: Bool

    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: image) // Using system images for consistency
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isActive ? .purple : .gray)
//            Text(text)
//                .font(.caption)
//                .foregroundColor(isActive ? .purple : .gray)
        }
    }
}
