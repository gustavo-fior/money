import SwiftUI

struct NewTransactionButton: View {
    @State var showingNewTransaction = false
    
    var body: some View {
        Button {
            showingNewTransaction = true
        } label: {
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color(.label))
                .foregroundColor(Color(.systemBackground))
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
        }
        .padding()
        .sheet(isPresented: $showingNewTransaction) {
            AddTransactionView()
        }
    }
}

#Preview {
    HomeView()
}
