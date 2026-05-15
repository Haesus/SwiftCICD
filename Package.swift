// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings: PackageSettings = .init(
  productTypes: [:],
  baseSettings: .packageSettings
)
#endif

let package = Package(
    name: "SwiftCICD",
    platforms: [.iOS(.v17)],
    dependencies: []
)
