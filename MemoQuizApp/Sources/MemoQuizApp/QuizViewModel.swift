import SwiftUI

struct QuizQuestion {
    let text: String
    let answers: [String]
    let correctIndex: Int
}

struct AlertInfo: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

final class QuizViewModel: ObservableObject {
    @Published var questions: [QuizQuestion] = []
    @Published var currentIndex: Int = 0
    @Published var alertInfo: AlertInfo?

    init() {
        loadQuestions()
    }

    func loadQuestions() {
        guard let path = Bundle.main.path(forResource: "Quizquestions", ofType: nil),
              let content = try? String(contentsOfFile: path) else {
            print("Failed to load questions")
            return
        }
        questions = parseQuestions(from: content).shuffled()
    }

    func parseQuestions(from text: String) -> [QuizQuestion] {
        var result: [QuizQuestion] = []
        var questionText: String = ""
        var answers: [String] = []
        var correct: Int = 0
        for line in text.components(separatedBy: "\n") {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.range(of: "^\\d+\\.", options: .regularExpression) != nil {
                if !questionText.isEmpty && !answers.isEmpty {
                    result.append(QuizQuestion(text: questionText, answers: answers, correctIndex: correct))
                }
                if let dotRange = trimmed.range(of: ".") {
                    questionText = String(trimmed[dotRange.upperBound...]).trimmingCharacters(in: .whitespaces)
                } else {
                    questionText = ""
                }
                answers = []
                correct = 0
            } else if trimmed.range(of: "^[A-Z]\\.", options: .regularExpression) != nil {
                var answer = String(trimmed.dropFirst(2)).trimmingCharacters(in: .whitespaces)
                let isCorrect = answer.contains("✅")
                answer = answer.replacingOccurrences(of: "✅", with: "").trimmingCharacters(in: .whitespaces)
                if isCorrect {
                    correct = answers.count
                }
                answers.append(answer)
            }
        }
        if !questionText.isEmpty && !answers.isEmpty {
            result.append(QuizQuestion(text: questionText, answers: answers, correctIndex: correct))
        }
        return result
    }

    func selectAnswer(_ index: Int) {
        let isCorrect = index == questions[currentIndex].correctIndex
        alertInfo = AlertInfo(title: isCorrect ? "Correct" : "Wrong",
                              message: isCorrect ? "Good job!" : "The correct answer was \(questions[currentIndex].answers[questions[currentIndex].correctIndex])")
    }

    func nextQuestion() {
        alertInfo = nil
        currentIndex += 1
    }

    func restart() {
        questions.shuffle()
        currentIndex = 0
    }
}
