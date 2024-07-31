import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State var selectedEmoji = "🙂"
    @State private var selectedColor: Color = .yellow
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray]
    
    var body: some View {
        VStack() {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Text("New Category")
                    .bold()
                Spacer()
                Button("Done") {
                    saveCategory()
                }
                .disabled(name.isEmpty)
            }
            .padding(.top, 24)
            
            Text(selectedEmoji)
                .font(.system(size: 42))
                .frame(width: 72, height: 72)
                .background(selectedColor.brightness(0.1))
                .clipShape(Circle())
                .padding(.top, 24)
                .animation(.easeInOut(duration: 0.3), value: selectedColor)
            
            VStack(alignment: .leading) {
                Text("Name")
                    .padding(.top)
                    .padding(.leading, 6)
                TextField("Groceries", text: $name)
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(12)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 48, height: 54)
                        .overlay(
                            Circle()
                                .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                        )
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding(.top, 24)
        }
        .padding(.horizontal, 24)
        
        Spacer()
    }
    
    private func saveCategory() {
        let newCategory = Category(name: name, emoji: selectedEmoji)
        modelContext.insert(newCategory)
        dismiss()
    }
}

#Preview {
    AddCategoryView()
}
