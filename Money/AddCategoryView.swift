import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var emoji = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Category Name", text: $name)
                TextField("Emoji", text: $emoji)
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCategory()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveCategory() {
        let newCategory = Category(name: name, emoji: emoji)
        modelContext.insert(newCategory)
        dismiss()
    }
}

#Preview {
    AddCategoryView()
}
