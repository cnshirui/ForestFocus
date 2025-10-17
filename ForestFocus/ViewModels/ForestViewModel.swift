import Foundation
import SwiftData

class ForestViewModel: ObservableObject {
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
