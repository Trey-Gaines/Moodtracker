//
//  MoodtrackerApp.swift
//  Moodtracker
//
//  Created by Trey Gaines on 6/8/25.
//

import SwiftUI
import SwiftData

@main
struct MoodtrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Mood.self,
        ])
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
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
