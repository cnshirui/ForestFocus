import XCTest
import SwiftData
@testable import ForestFocus

class StatsViewModelTests: XCTestCase {

    var modelContext: ModelContext!

    override func setUp() {
        super.setUp()
        let container = try! ModelContainer(for: Session.self, Tree.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        modelContext = container.mainContext
    }

    override func tearDown() {
        modelContext = nil
        super.tearDown()
    }

    func testStatisticsCalculation() {
        // Given
        let session1 = Session(id: UUID(), startTime: Date(), endTime: Date(), duration: 1500, status: .completed, tree: nil)
        let tree1 = Tree(id: UUID(), completionDate: Date(), session: session1)
        session1.tree = tree1
        modelContext.insert(session1)
        modelContext.insert(tree1)

        let session2 = Session(id: UUID(), startTime: Date(), endTime: Date(), duration: 1500, status: .completed, tree: nil)
        let tree2 = Tree(id: UUID(), completionDate: Date(), session: session2)
        session2.tree = tree2
        modelContext.insert(session2)
        modelContext.insert(tree2)

        let session3 = Session(id: UUID(), startTime: Date(), endTime: Date(), duration: 1000, status: .abandoned, tree: nil)
        modelContext.insert(session3)

        // When
        let viewModel = StatsViewModel(modelContext: modelContext)

        // Then
        XCTAssertEqual(viewModel.totalTrees, 2)
        XCTAssertEqual(viewModel.totalFocusTime, 3000)
        XCTAssertEqual(viewModel.todayTreeCount, 2)
        XCTAssertEqual(viewModel.dailyStreak, 1)
    }
}
