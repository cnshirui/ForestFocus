import Foundation
import Combine
import SwiftData

class TimerViewModel: ObservableObject {
    @Published var timerService = TimerService()
    @Published var treeGrowth: Double = 0.0

    var treeImageName: String {
        switch treeGrowth {
        case 0..<0.2:
            return "leaf"
        case 0.2..<0.4:
            return "camera.macro"
        case 0.4..<0.6:
            return "camera.macro.circle"
        case 0.6..<0.8:
            return "camera.macro.circle.fill"
        default:
            return "tree"
        }
    }

    private var modelContext: ModelContext
    private var cancellables = Set<AnyCancellable>()

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        timerService.$remainingTime.sink { [weak self] remainingTime in
            guard let self = self else { return }
            self.treeGrowth = 1.0 - (remainingTime / 1500.0)
        }.store(in: &cancellables)

        timerService.$timerState.sink { [weak self] timerState in
            guard let self = self else { return }
            if timerState == .completed {
                self.saveSession(status: .completed)
                NotificationManager.shared.scheduleNotification(title: "Session Complete!", body: "You've grown a new tree!", timeInterval: 1)
            }
        }.store(in: &cancellables)
    }

    func startSession() {
        timerService.start()
    }

    func pauseSession() {
        timerService.pause()
    }

    func resumeSession() {
        timerService.resume()
    }

    func cancelSession() {
        timerService.stop()
        saveSession(status: .abandoned)
    }

    func requestNotificationPermission() {
        NotificationManager.shared.requestAuthorization()
    }

    func handleScenePhaseChange(newPhase: ScenePhase) {
        if newPhase == .inactive && timerService.timerState == .running {
            cancelSession()
        }
    }

    private func saveSession(status: SessionStatus) {
        let session = Session(id: UUID(), startTime: Date(), endTime: Date(), duration: 1500 - timerService.remainingTime, status: status, tree: nil)
        if status == .completed {
            let tree = Tree(id: UUID(), completionDate: Date(), session: session)
            session.tree = tree
            modelContext.insert(tree)
        }
        modelContext.insert(session)
    }
}
