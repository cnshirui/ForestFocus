import Foundation
import Combine

class TimerService: ObservableObject {
    @Published var remainingTime: TimeInterval = 1500 // 25 minutes
    @Published var timerState: TimerState = .stopped

    private var timer: AnyCancellable?

    func start() {
        timerState = .running
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stop()
                self.timerState = .completed
            }
        }
    }

    func stop() {
        timer?.cancel()
        timer = nil
        timerState = .stopped
    }

    func pause() {
        timerState = .paused
        timer?.cancel()
        timer = nil
    }

    func resume() {
        start()
    }
}

enum TimerState {
    case running
    case stopped
    case paused
    case completed
}
