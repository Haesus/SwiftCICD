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
            dependencies: []
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
            dependencies: [.target(name: "SwiftCICD")]
        ),
    ]
)
