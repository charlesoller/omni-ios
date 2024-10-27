//
//  LayoutView.swift
//  Omni
//
//  Created by Charles Oller on 10/24/24.
//

import SwiftUI

struct LayoutView<Content: View>: View {
    @StateObject var userData = UserData()
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @State private var selectedTab: BottomBarSelectedTab = .home


    var body: some View {
        VStack {
            // Top Navigation Bar
            HStack {
                Text("Omni")
                    .font(.headline)
                Spacer()
                Button(action: {
                    // Handle menu action
                    print("Menu button tapped")
                }) {
                    Image(systemName: "line.horizontal.3") // Hamburger menu icon
                        .font(.title) // Set the icon size
                        .foregroundColor(.gray) // Set the icon color
                }
            }
            .padding()
//            .background(Color.gray.opacity(0.2))

            // Content area
            contentView(for: selectedTab)
                .padding()

            // Bottom Navigation Bar
            BottomBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom) // Optional: Ignore safe area for bottom nav
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

