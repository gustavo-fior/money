import SwiftUI

struct AddTransactionView: View {
    @State private var amount = "0.0"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline.weight(.semibold))
                            .padding(12)
                            .background(Color.primary)
                            .foregroundColor(Color.gray)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                
                Spacer()
                
                withAnimation {
                    Text(Double(amount)?.formatted(
                        .currency(code:"BRL")
                    ) ?? "0.0")
                    .font(.system(size: 48, weight: .bold))
                    .padding(.vertical, 50)
                }
                
                Spacer()
                
                NumberPad(amount: $amount)
                
                NavigationLink(destination: CategoriesView()) {
                    ZStack {
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                        Text("Continue")
                    }
                    .font(.title.weight(.medium))
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,16)
                    .padding(.horizontal,20)
                    .background(Color.primary)
                    .cornerRadius(12)
                }
                .padding(.top, 12)
                .padding(.horizontal, 24)
            }.padding()
        }
    }
}

#Preview {
    AddTransactionView()
}
