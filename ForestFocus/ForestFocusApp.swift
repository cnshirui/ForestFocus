//
//  ForestFocusApp.swift
//  ForestFocus
//
//  Created by flame on 10/16/25.
//

import SwiftUI
import SwiftData

@main
struct ForestFocusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Session.self, Tree.self])
    }
}
