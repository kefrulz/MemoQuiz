import SwiftUI

@main
struct MemoQuizApp: App {
    @StateObject private var viewModel = QuizViewModel()

    var body: some Scene {
        WindowGroup {
            QuizView()
                .environmentObject(viewModel)
        }
    }
}
