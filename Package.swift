// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "CoreSession",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "CoreSession", targets: ["CoreSession"]),
  ],
  dependencies: [],
  targets: [
    .target(name: "CoreSession"),
    .testTarget(
      name: "CoreSessionTests",
      dependencies: ["CoreSession"],
      path: "Tests/CoreSessionTests"
    )
  ]
)
