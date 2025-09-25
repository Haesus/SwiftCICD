import ProjectDescription

let project = Project(
    name: "SwiftCICD",
    targets: [
        .target(
            name: "SwiftCICD",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.SwiftCICD",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "ITSAppUsesNonExemptEncryption": false,
                ]
            ),
            buildableFolders: [
                "SwiftCICD/Sources",
                "SwiftCICD/Resources",
                "fastlane",
                ".github"
            ],
            dependencies: [],
            settings: .settings(
                base: [
                    "CODE_SIGN_STYLE": "Manual",
                    "DEVELOPMENT_TEAM": "3TGR3P459K",
                    "MARKETING_VERSION": "1.0.0", // CFBundleShortVersionString
                    "CURRENT_PROJECT_VERSION": "1", // CFBundleVersion (빌드번호)
                    "VERSIONING_SYSTEM": "apple-generic",
                    "TARGETED_DEVICE_FAMILY": "1",
                ],
                configurations: [
                    .release(name: "Release", settings: [
                        "CODE_SIGN_STYLE": "Manual",
                        "CODE_SIGN_IDENTITY": "Apple Distribution",
                        "PROVISIONING_PROFILE_SPECIFIER": "match AppStore dev.tuist.SwiftCICD"
                    ]),
                    .debug(name: "Debug", settings: [
                        "CODE_SIGN_STYLE": "Manual",
                        "CODE_SIGN_IDENTITY": "Apple Development",
                        "PROVISIONING_PROFILE_SPECIFIER": "match Development dev.tuist.SwiftCICD"
                    ])
                ]
            )
        ),
        .target(
            name: "SwiftCICDTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.SwiftCICD",
            infoPlist: .default,
            buildableFolders: [
                "SwiftCICD/Tests"
            ],
            dependencies: [.target(name: "SwiftCICD")],
            settings: .settings(
              base: [
                "DEVELOPMENT_TEAM": "3TGR3P459K"
              ],
              configurations: [
                .debug(name: "Debug", settings: [
                  "CODE_SIGN_STYLE": "Automatic"
                ]),
                .release(name: "Release", settings: [
                  "CODE_SIGN_STYLE": "Automatic"
                ])
              ]
            )
        ),
    ]
)
