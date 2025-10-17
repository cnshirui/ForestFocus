//
//  ContentView.swift
//  ForestFocus
//
//  Created by flame on 10/16/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        TimerView(modelContext: modelContext)
    }
}

#Preview {
    ContentView()
}
