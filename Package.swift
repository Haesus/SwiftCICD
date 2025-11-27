//
//  Package.swift
//  Tuist
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//
// swift-tools-version: 6.0

import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings: PackageSettings = .init(
  // Customize the product types for specific package product
  // Default is .staticFramework
  // productTypes: ["Alamofire": .framework,]
    productTypes: [:],
    baseSettings: .packageSettings
  )
#endif

let package = Package(
  name: "TestTemplate",
  dependencies: [
    // Add your own dependencies here:
    // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
    // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
//    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.23.1"),
//    .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.10.2"),
//    .package(url: "https://github.com/auth0/JWTDecode.swift", exact: "3.3.0"),
  ]
)
