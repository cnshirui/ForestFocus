import Foundation
import SwiftData

@Model
final class Tree {
    var id: UUID
    var completionDate: Date
    var session: Session?

    init(id: UUID, completionDate: Date, session: Session? = nil) {
        self.id = id
        self.completionDate = completionDate
        self.session = session
    }
}
