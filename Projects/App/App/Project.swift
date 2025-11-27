//
//  Project.swift
//  AppManifests
//
//  Created by 윤해수 on 11/27/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

// MARK: - Target
let scripts: [TargetScript] = if currentConfig == .dev {
  [.reveal(target: .dev)]
} else {
  []
}

let appTargetName = "TestTemplate"
let appTarget: Target = .target(
  name: appTargetName,
  destinations: AppEnv.platform,
  product: .app,
  bundleId: AppEnv.bundleId,
  deploymentTargets: AppEnv.deploymentTarget,
  infoPlist: InfoPlist.TestTemplate.app,
  sources: [
    "Sources/**"
  ],
  resources: .resources(
    [
      "Resources/\(currentConfig.name)/**"
    ],
    privacyManifest: .testTemplate
  ),
  entitlements: Entitlements.TestTemplate.app,
  scripts: scripts,
  dependencies: [
    .dependency(rootModule: Feature.self)
  ],
  settings: .targetSettings(product: .app)
)

// MARK: - Scheme
let appScheme = Scheme.makeAppScheme(
  target: TargetReference(stringLiteral: appTargetName),
  config: currentConfig
)

// MARK: - Project
let project: Project = .init(
  name: "TestApp",
  organizationName: AppEnv.organizationName,
  options: .options(automaticSchemesOptions: .disabled, disableSynthesizedResourceAccessors: true),
  settings: .projectSettings(xcconfig: .appXCConfig(for: currentConfig)),
  targets: [appTarget],
  schemes: [appScheme]
)
