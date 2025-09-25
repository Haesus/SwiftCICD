import ProjectDescription

let project = Project(
    name: "SwiftCICD",
    settings: .settings(
        base: [
            "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
            "DEVELOPMENT_TEAM": "3TGR3P459K", // 팀ID
            "STRING_CATALOG_GENERATE_SWIFT_SYMBOLS": "YES", // 문자열 심볼 생성
            "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
            "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": "YES" // 에셋 심볼 익스텐션 생성
        ]
    ),
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
    ],
    additionalFiles: [
        .glob(pattern: "Project.swift"), // Xcode 네비게이터에 표시(타겟에는 미포함)
        .folderReference(path: "fastlane"), // 폴더 통째로 참조(빌드 산출물 아님)
        .folderReference(path: ".github") // 워크플로 폴더도 보이게
    ]
)
