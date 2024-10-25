//
//  ContentView.swift
//  WeSplit
//
//  Created by Charles Oller on 10/23/24.
//

import SwiftUI

struct SwiperView: View {
    @Environment(\.colorScheme) var colorScheme

    // Variables to track the current card's position
    @State private var scaleEffect: CGFloat = 1.0
    @State private var offset = CGSize.zero
    @State private var rotation: Double = 0
    @State private var isSwiped = false
    
    @State private var showMovieDetails = false
    @State private var selectedCard: Int? = nil  // To track the card being long pressed
    
    // List of cards (placeholders for now)
    @State private var cards = Array(1...5)  // Example card identifiers
    
    
    
    var body: some View {
        VStack {
            ZStack {
                // Loop through the list of cards and display the topmost one
                ForEach(cards, id: \.self) { card in
                    MovieCardView(cardNumber: card)
                        .scaleEffect(isTopCard(card: card) ? scaleEffect : 1.0) // Apply scale effect conditionally
                        .offset(x: isTopCard(card: card) ? offset.width : 0, y: isTopCard(card: card) ? offset.height : 0)
                        .rotationEffect(isTopCard(card: card) ? .degrees(rotation) : .zero)
                        .scaleEffect(isTopCard(card: card) ? 1.0 : 0.95)  // Slight scale for cards behind
                        .opacity(isTopCard(card: card) ? 1.0 : 0.5)  // Faded opacity for back cards
                        .zIndex(isTopCard(card: card) ? 1 : 0)  // Top card appears on top
                        .gesture(
                            LongPressGesture(minimumDuration: 1.0) // Long press gesture to show details
                                .onEnded { _ in
                                    if isTopCard(card: card) {
                                        selectedCard = card
                                        showMovieDetails = true
                                    }
                                }
                                .simultaneously(with:
                                    DragGesture()
                                        .onChanged { gesture in
                                            if isTopCard(card: card) {
                                                scaleEffect = 1.05
                                                offset = gesture.translation
                                                rotation = Double(gesture.translation.width / 20)
                                            }
                                        }
                                        .onEnded { gesture in
                                            if isTopCard(card: card) {
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
            MovieDetailsView(cardNumber: selectedCard ?? 0) // Pass the selected card to details
        }
    }
    
    // Check if the card is the topmost one in the stack
    private func isTopCard(card: Int) -> Bool {
        return card == cards.first
    }
    
    // Swipe card off screen function
    func swipeCard(to direction: SwipeDirection) {
        // Move the card off screen depending on direction
        switch direction {
        case .left:
            offset = CGSize(width: -1000, height: 0)
        case .right:
            offset = CGSize(width: 1000, height: 0)
        }
        
        // After the card is swiped, replace it with the next card
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let firstCard = cards.removeFirst()  // Remove the top card
            cards.append(firstCard)  // Move the removed card to the back (infinite loop)
            resetCard()  // Reset the position for the new top card
        }
        
        isSwiped = true
    }
    
    // Reset the card position
    func resetCard() {
        offset = .zero
        rotation = 0
    }
    
    // Enum to define swipe directions
    enum SwipeDirection {
        case left, right
    }
}

// A simple Card view for testing (replace with your movie card later)


  
#Preview {
    SwiperView()
}
