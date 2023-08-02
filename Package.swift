// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of
// Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CoreSession",
  platforms: [
    .iOS(.v15),
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "CoreSession",
      targets: ["CoreSession"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "CoreSession",
      dependencies: []
    )
  ]
)
