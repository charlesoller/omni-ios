import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var embedding: [Float] = Array(repeating: 0.0, count: 384)
}
