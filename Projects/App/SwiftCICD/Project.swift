import ProjectDescription
import ProjectDescriptionHelpers

let appTargetName = "SwiftCICD"

let appTarget: Target = .target(
  name: appTargetName,
  destinations: AppEnv.platform,
  product: .app,
  bundleId: AppEnv.bundleId,
  deploymentTargets: AppEnv.deploymentTarget,
  infoPlist: InfoPlist.SwiftCICD.app,
  sources: [
    "Sources/**"
  ],
  resources: .resources(
    [
      "Resources/\(currentConfig.name)/**",
      "Resources/Assets.xcassets"
    ],
    privacyManifest: .SwiftCICD
  ),
  dependencies: [],
  settings: .targetSettings(product: .app)
)

let testsTarget: Target = .target(
  name: "\(appTargetName)Tests",
  destinations: AppEnv.platform,
  product: .unitTests,
  bundleId: "\(AppEnv.bundleId).tests",
  deploymentTargets: AppEnv.deploymentTarget,
  infoPlist: .default,
  sources: [
    "Tests/**"
  ],
  dependencies: [
    .target(name: appTargetName)
  ],
  settings: .targetSettings(product: .unitTests)
)

let appScheme = Scheme.makeAppScheme(
  target: TargetReference(stringLiteral: appTargetName),
  config: currentConfig,
  testTargets: [
    .testableTarget(
      target: TargetReference(stringLiteral: "\(appTargetName)Tests"),
      parallelization: .disabled
    )
  ]
)

let project = Project(
  name: "App",
  organizationName: AppEnv.organizationName,
  options: .options(
    automaticSchemesOptions: .disabled,
    disableSynthesizedResourceAccessors: true
  ),
  settings: .projectSettings(xcconfig: .appXCConfig(for: currentConfig)),
  targets: [
    appTarget,
    testsTarget
  ],
  schemes: [
    appScheme
  ]
)
