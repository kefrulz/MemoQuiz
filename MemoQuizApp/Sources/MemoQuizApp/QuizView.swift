import SwiftUI

struct QuizView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @State private var showConfig = false

    var body: some View {
        NavigationView {
            if viewModel.currentIndex < viewModel.questions.count {
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.questions[viewModel.currentIndex].text)
                        .font(.title2)
                    ForEach(viewModel.questions[viewModel.currentIndex].answers.indices, id: .self) { index in
                        Button(action: {
                            viewModel.selectAnswer(index)
                        }) {
                            Text(viewModel.questions[viewModel.currentIndex].answers[index])
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Question \(viewModel.currentIndex + 1)/\(viewModel.questions.count)")
                .alert(item: $viewModel.alertInfo) { info in
                    Alert(title: Text(info.title), message: Text(info.message), dismissButton: .default(Text("Next")) {
                        viewModel.nextQuestion()
                    })
                }
            } else {
                VStack(spacing: 20) {
                    Text("Quiz Completed!")
                        .font(.largeTitle)
                    Button("Restart") {
                        viewModel.restart()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Configure") {
                    showConfig = true
                }
            }
        }
        .sheet(isPresented: $showConfig) {
            QuestionConfigView().environmentObject(viewModel)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView().environmentObject(QuizViewModel())
    }
}
