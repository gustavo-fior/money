import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .toolbarBackground(.background, for: .tabBar)
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .toolbarBackground(.background, for: .tabBar)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .toolbarBackground(.background, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
