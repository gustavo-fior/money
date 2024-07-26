import Foundation
import SwiftData

@Model
class Category : Identifiable {
    var id: UUID
    var name: String
    var emoji: String
    
    @Relationship(deleteRule: .cascade)
    var transactions: [Transaction]? = []
    
    init(name: String, emoji: String) {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
    }
}
