import SwiftUI
import SwiftData

@main
struct MyCity2App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SavedEvent.self,
            EventCollection.self,
        ])// här startar ja the data base when the app is start
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
