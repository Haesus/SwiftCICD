# SwiftCICD

Tuist와 Fastlane을 기본으로 사용하는 iOS 초기 프로젝트 뼈대입니다.

## Structure

```text
Projects/
  App/SwiftCICD/       # 앱 타겟, 리소스, 테스트
  Feature/Feature/     # Feature 루트 모듈
  Domain/Domain/       # Domain 루트 모듈
  Core/Core/           # Core 루트 모듈
  Shared/Shared/       # Shared 루트 모듈
Tuist/                 # Tuist helpers, templates, resource synthesizers
Plugins/               # Tuist local plugins
Xcconfig/              # DEV / BETA / RELEASE 설정
fastlane/              # TestFlight 배포 자동화
```

## Commands

```bash
make install
make dev
make beta
make release
```

새 모듈은 템플릿으로 생성합니다.

```bash
make scaffold layer=Feature name=ExampleFeature
```

`Plugins/DependencyPlugin/ProjectDescriptionHelpers/Module` 아래 enum에 새 모듈 case를 추가하면 `Workspace.swift`와 `TargetDependency.dependency(module:)`에서 같은 규칙으로 사용할 수 있습니다.

## Build

```bash
TUIST_BUILD_CONFIG=dev tuist generate
xcodebuild -workspace SwiftCICD.xcworkspace -scheme SwiftCICD_DEV -configuration DEV -destination 'generic/platform=iOS Simulator' build
```

Fastlane 배포는 `TUIST_BUILD_CONFIG` 값에 따라 `DEV`, `BETA`, `RELEASE` 번들 ID와 스킴을 선택합니다.

## Initial Setup Checklist

새 프로젝트로 사용할 때는 아래 값을 먼저 교체하세요. 각 파일에도 `TODO` 주석을 남겨 두었습니다.

- `Tuist/ProjectDescriptionHelpers/AppEnv.swift`: organization name, DEV/BETA/RELEASE bundle identifier
- `Xcconfig/Project/*.xcconfig`: `DEVELOPMENT_TEAM`, `APP_NAME`, version 값
- `fastlane/Appfile`: release app identifier, Apple ID, App Store Connect Team ID, Developer Team ID
- `fastlane/Matchfile`: match 인증서 저장소 URL/브랜치, DEV/BETA/RELEASE app identifier, Apple Developer 로그인 이메일
- `.github/workflows/testflight-ci.yml`: `ASC_*`, `MATCH_*`, `MATCH_SSH_PRIVATE_KEY`, `TUIST_BUILD_CONFIG` GitHub Secrets/환경값

민감 정보는 코드에 직접 넣지 말고 GitHub Secrets, Keychain, 앱 설정 화면 같은 외부 주입 방식을 사용하세요.
