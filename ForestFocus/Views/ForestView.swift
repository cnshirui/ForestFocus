import SwiftUI
import SwiftData

struct ForestView: View {
    @Query private var trees: [Tree]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(trees) { tree in
                    Image(systemName: "tree")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .accessibilityLabel("A grown tree")
                }
            }
        }
        .navigationTitle("Forest")
    }
}
