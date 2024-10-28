import Foundation

class EmbeddingService {
    func moveTo(userEmbedding: [Float], likedEmbedding: [Float], factor: Float = 0.5) -> [Float]? {
        guard userEmbedding.count == 384, likedEmbedding.count == 384 else {
            print("Error: Both embeddings must have exactly 384 indices.")
            return nil
        }
        
        var adjustedEmbedding = [Float](repeating: 0.0, count: 384)
        
        for i in 0..<384 {
            adjustedEmbedding[i] = userEmbedding[i] + (likedEmbedding[i] * factor)
        }
        
        return adjustedEmbedding
    }
    
    func moveAway(userEmbedding: [Float], dislikedEmbedding: [Float], factor: Float = 0.5) -> [Float]? {
        guard userEmbedding.count == 384, dislikedEmbedding.count == 384 else {
            print("Error: Both embeddings must have exactly 384 indices.")
            return nil
        }
        
        var adjustedEmbedding = [Float](repeating: 0.0, count: 384)
        
        for i in 0..<384 {
            adjustedEmbedding[i] = userEmbedding[i] - (dislikedEmbedding[i] * factor)
        }
        
        return adjustedEmbedding
    }
}
