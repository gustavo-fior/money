import SwiftUI
import SwiftData
import EmojiPicker

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State var selectedEmoji: Emoji? = Emoji(value: "😄", name: "smile")
    @State private var selectedColor: Color = .yellow
    @State private var isEmojiPickerPresented = false
    
    
    let emojis = ["📝", "📚", "🎨", "🏋️‍♀️", "🍳", "🧘‍♀️", "🛒", "💼", "🏠", "🌿", "🐾", "❤️", "👥", "🎓", "🎮", "🎵", "✈️", "🚗", "💡", "🔧"]
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Button(action: {
                            isEmojiPickerPresented = true
                        }) {
                            Text(selectedEmoji?.value ?? "")
                                .font(.system(size: 40))
                                .frame(width: 72, height: 72)
                                .background(selectedColor.brightness(0.3))
                            
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        TextField("List Name", text: $name)
                            .padding(.top)
                    }
                }
                
                Section(header: Text("Choose a color")) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
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
            .sheet(isPresented: $isEmojiPickerPresented) {
                        NavigationView {
                            EmojiPickerView(selectedEmoji: $selectedEmoji, selectedColor: .orange)
                                .navigationTitle("Emojis")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
        }
    }
    
    private func saveCategory() {
        let newCategory = Category(name: name, emoji: selectedEmoji?.value ?? "")
        modelContext.insert(newCategory)
        dismiss()
    }
}

#Preview {
    AddCategoryView()
}
