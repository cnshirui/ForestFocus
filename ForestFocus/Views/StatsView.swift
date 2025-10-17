import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel: StatsViewModel

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: StatsViewModel(modelContext: modelContext))
    }

    var body: some View {
        VStack {
            Text("Total Trees: \(viewModel.totalTrees)")
                .accessibilityLabel("Total trees grown")
                .accessibilityValue("\(viewModel.totalTrees)")
            Text("Total Focus Time: \(viewModel.totalFocusTime / 60) minutes")
                .accessibilityLabel("Total focus time")
                .accessibilityValue("\(viewModel.totalFocusTime / 60) minutes")
            Text("Today's Trees: \(viewModel.todayTreeCount)")
                .accessibilityLabel("Trees grown today")
                .accessibilityValue("\(viewModel.todayTreeCount)")
            Text("Daily Streak: \(viewModel.dailyStreak) days")
                .accessibilityLabel("Current daily streak")
                .accessibilityValue("\(viewModel.dailyStreak) days")
        }
        .navigationTitle("Statistics")
    }
}
