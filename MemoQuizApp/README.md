# MemoQuizApp

A basic SwiftUI quiz app that loads questions from a text file bundled with the app. The repository ships with **14** questions, and each correct answer is marked with a trailing `✅`. You can edit the list at runtime from the configuration screen.

## Building
1. Open the `MemoQuizApp` folder in Xcode.
2. Ensure the `Quizquestions` resource is included in the target.
3. Build and run on an iOS device or simulator running iOS 16 or later.

### GitHub Actions
A workflow is provided to build an unsigned IPA on pushes and pull requests.
