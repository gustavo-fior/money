import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var selectedIcon = "list.bullet"
    @State private var selectedColor: Color = .gray
    
    let icons = ["list.bullet", "book", "pencil", "folder", "gift", "graduationcap", "house", "building", "cart", "gamecontroller", "headphones", "leaf", "pawprint", "heart", "person.2", "person.3"]
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray]

    
    var body: some View {
            NavigationView {
                Form {
                    Section {
                        HStack {
                            Image(systemName: selectedIcon)
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(selectedColor)
                                .clipShape(Circle())
                            
                            TextField("Groceries", text: $name)
                        }
                    }
                    
                    Section(header: Text("Choose a color")) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                            ForEach(colors, id: \.self) { color in
                                Circle()
                                    .fill(color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                                    )
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                            }
                        }
                    }
                    
                    Section(header: Text("Choose an icon")) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                            ForEach(icons, id: \.self) { icon in
                                Image(systemName: icon)
                                    .foregroundColor(selectedIcon == icon ? .blue : .white)
                                    .frame(width: 40, height: 40)
                                    .background(selectedIcon == icon ? selectedColor : Color.secondary)
                                    .clipShape(Circle())
                                    .padding(3)
                                    .overlay(
                                        selectedIcon == icon ?
                                        Circle()
                                            .stroke(Color.primary, lineWidth: 2)
                                        : nil
                                    )
                                    .onTapGesture {
                                        selectedIcon = icon
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("New List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            saveCategory()
                        }
                        .disabled(name.isEmpty)
                    }
                }
            }
        }
        
        private func saveCategory() {
            let newCategory = Category(name: name, emoji: selectedIcon)
            modelContext.insert(newCategory)
            dismiss()
        }
}

#Preview {
    AddCategoryView()
}
