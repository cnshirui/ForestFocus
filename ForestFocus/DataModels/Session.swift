import Foundation
import SwiftData

@Model
final class Session {
    var id: UUID
    var startTime: Date
    var endTime: Date
    var duration: TimeInterval
    var status: SessionStatus
    @Relationship(deleteRule: .cascade) var tree: Tree?

    init(id: UUID, startTime: Date, endTime: Date, duration: TimeInterval, status: SessionStatus, tree: Tree?) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
        self.status = status
        self.tree = tree
    }
}

enum SessionStatus: Codable {
    case completed
    case abandoned
}
