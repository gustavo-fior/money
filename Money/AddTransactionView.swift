import SwiftUI

struct AddTransactionView: View {
    @State private var amount = "0"
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
                            .background(Color(.gray))
                            .foregroundColor(Color(.systemBackground))
                            .clipShape(Circle())
                    }
                    .padding()
                }
                
                Spacer()
                
                
                HStack {
                    Text("R$")
                        .font(.system(size: 32, weight: .regular))
                        .padding(.vertical, 50)
                        .foregroundColor(.gray)
                    HStack(spacing: 0) {
                        ForEach(Array(amount.enumerated()), id: \.offset) { index, character in
                            Text(String(character))
                                .font(.system(size: 48, weight: .bold))
                                .transition(.asymmetric(
                                    insertion: .scale(scale: 0.5, anchor: .bottom).combined(with: .opacity).animation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.2)),
                                    removal: .scale(scale: 0.5, anchor: .top).combined(with: .opacity).animation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.2))
                                ))
                                .animation(index == amount.count - 1 ?
                                    .spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.2) :
                                        .spring(response: 0.2, dampingFraction: 0.8, blendDuration: 0.1),
                                           value: amount
                                )
                        }
                    }
                }
                .animation(.snappy, value: amount)
                
                
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
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,16)
                    .padding(.horizontal,20)
                    .background(Color(.label))
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
