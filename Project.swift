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
                ]
            ),
            buildableFolders: [
                "SwiftCICD/Sources",
                "SwiftCICD/Resources",
            ],
            dependencies: [],
            settings: .settings(
                base: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "3TGR3P459K"
                ]
            )
        ),
        .target(
            name: "SwiftCICDTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.SwiftCICDTests",
            infoPlist: .default,
            buildableFolders: [
                "SwiftCICD/Tests"
            ],
            dependencies: [.target(name: "SwiftCICD")],
            settings: .settings(
                base: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "3TGR3P459K"
                ]
            )
        ),
    ]
)
