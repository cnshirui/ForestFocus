import XCTest
@testable import ForestFocus

class TimerServiceTests: XCTestCase {

    var timerService: TimerService!

    override func setUp() {
        super.setUp()
        timerService = TimerService()
    }

    override func tearDown() {
        timerService = nil
        super.tearDown()
    }

    func testTimerStarts() {
        timerService.start()
        XCTAssertEqual(timerService.timerState, .running)
    }

    func testTimerStops() {
        timerService.start()
        timerService.stop()
        XCTAssertEqual(timerService.timerState, .stopped)
    }

    func testTimerPauses() {
        timerService.start()
        timerService.pause()
        XCTAssertEqual(timerService.timerState, .paused)
    }

    func testTimerResumes() {
        timerService.start()
        timerService.pause()
        timerService.resume()
        XCTAssertEqual(timerService.timerState, .running)
    }

    func testTimerCompletes() {
        timerService.remainingTime = 1
        timerService.start()
        let expectation = XCTestExpectation(description: "Timer completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.timerService.timerState, .completed)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
        func testSessionAbandonment() {
            let modelContext = try! ModelContainer(for: Session.self, Tree.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext
            let viewModel = TimerViewModel(modelContext: modelContext)
    
            viewModel.startSession()
            viewModel.cancelSession()
    
            let descriptor = FetchDescriptor<Session>()
            let sessions = try! modelContext.fetch(descriptor)
    
            XCTAssertEqual(sessions.count, 1)
            XCTAssertEqual(sessions.first?.status, .abandoned)
        }
    }
