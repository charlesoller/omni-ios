import SwiftUI

struct LayoutView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var userData = UserData()
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @State private var selectedTab: BottomBarSelectedTab = .home
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Main content area
                contentView(for: selectedTab)
                    .padding(.top, 60) // Adjust based on your top nav height
                    .padding(.bottom, 70) // Adjust based on your bottom nav height
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Top Navigation Bar
                VStack {
                    HStack {
                        Text("Omni")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            print("Menu button tapped")
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 80) // Fixed height for top nav
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .shadow(radius: 3)
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.top, geometry.safeAreaInsets.top)
                .background(Color(UIColor.systemBackground))
                .ignoresSafeArea(edges: .top)
                
                // Bottom Navigation Bar
                VStack {
                    Spacer()
                    BottomBar(selectedTab: $selectedTab)
                        .frame(height: 70) // Fixed height for bottom nav
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .background(
                            Rectangle()
                                .fill(Color(UIColor.systemBackground))
                                .shadow(radius: 3, y: -2)
                        )

                }
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .ignoresSafeArea(edges: [.top, .bottom])
    }
    
    @ViewBuilder
    private func contentView(for tab: BottomBarSelectedTab) -> some View {
        switch tab {
        case .home:
            SwiperView()
                .environmentObject(userData)
        case .search:
            SearchView()
                .environmentObject(userData)
        case .profile:
            UserProfileView()
                .environmentObject(userData)
        }
    }
}

#Preview {
    ContentView()
}
