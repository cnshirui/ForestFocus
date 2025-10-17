import Foundation
import SwiftData

class StatsViewModel: ObservableObject {
    @Published var totalTrees: Int = 0
    @Published var totalFocusTime: TimeInterval = 0
    @Published var todayTreeCount: Int = 0
    @Published var dailyStreak: Int = 0

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchStatistics()
    }

    func fetchStatistics() {
        let descriptor = FetchDescriptor<Session>()
        guard let sessions = try? modelContext.fetch(descriptor) else { return }

        let completedSessions = sessions.filter { $0.status == .completed }
        totalTrees = completedSessions.count
        totalFocusTime = completedSessions.reduce(0) { $0 + $1.duration }

        let today = Calendar.current.startOfDay(for: Date())
        todayTreeCount = completedSessions.filter { Calendar.current.isDate($0.endTime, inSameDayAs: today) }.count

        dailyStreak = calculateDailyStreak(sessions: completedSessions)
    }

    private func calculateDailyStreak(sessions: [Session]) -> Int {
        guard !sessions.isEmpty else { return 0 }

        let sortedSessions = sessions.sorted { $0.endTime > $1.endTime }
        var streak = 0
        var currentDate = Calendar.current.startOfDay(for: Date())

        var uniqueDays = Set<Date>()
        for session in sortedSessions {
            uniqueDays.insert(Calendar.current.startOfDay(for: session.endTime))
        }

        while uniqueDays.contains(currentDate) {
            streak += 1
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        }

        return streak
    }
}
