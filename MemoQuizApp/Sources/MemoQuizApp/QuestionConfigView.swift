import SwiftUI

struct QuestionConfigView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .padding()
                .onAppear {
                    text = viewModel.rawText
                }
                .navigationTitle("Edit Questions")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            viewModel.updateQuestions(from: text)
                            dismiss()
                        }
                    }
                }
        }
    }
}

struct QuestionConfigView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionConfigView().environmentObject(QuizViewModel())
    }
}
