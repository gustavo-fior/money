import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    @State private var showingAddCategory = false
    
    var body: some View {
            Group {
                if categories.isEmpty {
                    VStack {
                        Text("No categories yet")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Button(action: { showingAddCategory = true }) {
                            Text("Add Category")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top)
                    }
                } else {
                    List {
                        ForEach(categories) { category in
                            HStack {
                                Text(category.emoji)
                                Text(category.name)
                            }
                        }
                        .onDelete(perform: deleteCategories)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showingAddCategory = true }) {
                                Label("Add Category", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .sheet(isPresented: $showingAddCategory) {
                AddCategoryView()
            }
        }
    
    private func deleteCategories(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(categories[index])
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Category.self, configurations: config)
        
        let sampleCategories = [
            Category(name: "Category1", emoji: "💡"),
            Category(name: "Category2", emoji: "🥳"),
            Category(name: "Category3", emoji: "🥹")
        ]
        
        sampleCategories.forEach { category in
            container.mainContext.insert(category)
        }
        
        return NavigationStack {
            CategoriesView()
        }
        .modelContainer(container)
    } catch {
        fatalError("Failed to create model container: \(error.localizedDescription)")
    }
}

#Preview("Empty State") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Category.self, configurations: config)
        
        return NavigationStack {
            CategoriesView()
        }
        .modelContainer(container)
    } catch {
        fatalError("Failed to create model container: \(error.localizedDescription)")
    }
}
