// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "MemoQuizApp",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(name: "MemoQuizApp", targets: ["MemoQuizApp"])
    ],
    targets: [
        .executableTarget(
            name: "MemoQuizApp",
            resources: [.process("Resources")]
        )
    ]
)
