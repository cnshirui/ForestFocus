import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel: TimerViewModel

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: TimerViewModel(modelContext: modelContext))
    }

    var body: some View {
        VStack {
            Text("\(Int(viewModel.timerService.remainingTime) / 60):\(Int(viewModel.timerService.remainingTime) % 60, specifier: "%02d")")
                .font(.largeTitle)
                .accessibilityLabel("Timer")
                .accessibilityValue("\(Int(viewModel.timerService.remainingTime)) seconds remaining")

            Image(systemName: viewModel.treeImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .animation(.easeInOut, value: viewModel.treeImageName)


            HStack {
                Button(action: {
                    viewModel.startSession()
                }) {
                    Text("Start")
                }
                .disabled(viewModel.timerService.timerState == .running)
                .accessibilityHint("Starts a new 25-minute focus session")

                Button(action: {
                    viewModel.pauseSession()
                }) {
                    Text("Pause")
                }
                .disabled(viewModel.timerService.timerState != .running)
                .accessibilityHint("Pauses the current focus session")

                Button(action: {
                    viewModel.resumeSession()
                }) {
                    Text("Resume")
                }
                .disabled(viewModel.timerService.timerState != .paused)
                .accessibilityHint("Resumes the paused focus session")

                Button(action: {
                    viewModel.cancelSession()
                }) {
                    Text("Cancel")
                }
                .disabled(viewModel.timerService.timerState == .stopped)
                .accessibilityHint("Cancels the current focus session")
            }
        }
        .onAppear {
            viewModel.requestNotificationPermission()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            viewModel.handleScenePhaseChange(newPhase: newPhase)
        }
    }
}
