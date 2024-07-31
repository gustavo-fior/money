import Foundation
import SwiftData

@Model
class Transaction : Identifiable {
    var id: UUID
    var value: Double
    var date: Date
    var desc: String
    
    @Relationship(deleteRule: .cascade)
    var category: Category?
    
    init(value: Double, date: Date, desc: String, category: Category) {
        self.id = UUID()
        self.value = value
        self.date = date
        self.desc = desc
        self.category = category
    }
}
