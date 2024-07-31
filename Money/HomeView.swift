import SwiftUI

struct HomeView: View {
    var body: some View {
        
        List(0..<100) { i in
            Text("Item \(i)")
        }
        .navigationTitle("Home")
        .overlay(alignment: .bottomTrailing) {
            NewTransactionButton()
        }
    }
}

#Preview {
    HomeView()
}
