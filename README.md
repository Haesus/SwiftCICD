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

Tuist 버전은 `.mise.toml`에서 고정합니다. Swift Package 의존성은 루트 `Package.swift`를 단일 진입점으로 사용합니다.

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
- `fastlane/Appfile`: `APP_IDENTIFIER_RELEASE`, `FASTLANE_APPLE_ID`, `FASTLANE_ITC_TEAM_ID`, `DEVELOPMENT_TEAM`
- `fastlane/Matchfile`: `MATCH_GIT_URL` 또는 `MATCH_GIT_URL_SSH`, `MATCH_GIT_BRANCH`, `APP_IDENTIFIER_*`, `FASTLANE_APPLE_ID`
- `fastlane/Fastfile`: `APP_IDENTIFIER_DEV`, `APP_IDENTIFIER_BETA`, `APP_IDENTIFIER_RELEASE`
- `.github/workflows/testflight-ci.yml`: `ASC_*`, `MATCH_*`, `MATCH_SSH_PRIVATE_KEY`, `FASTLANE_*`, `APP_IDENTIFIER_*`, `TUIST_BUILD_CONFIG` GitHub Secrets/환경값
- `Tuist/ProjectDescriptionHelpers/PrivacyManifest.swift`: 실제 수집 데이터와 민감 API 사용 사유

민감 정보는 코드에 직접 넣지 말고 GitHub Secrets, Keychain, 앱 설정 화면 같은 외부 주입 방식을 사용하세요.

`TestFlight CI`는 초기 템플릿 상태에서 비밀값 없이 자동 실패하지 않도록 수동 실행(`workflow_dispatch`)만 켜 두었습니다. `main` 머지 시 자동 배포가 필요하면 `.github/workflows/testflight-ci.yml`의 `push` 트리거 주석을 해제하세요.

Jira 연동 워크플로(`auto-connect-jira.yml`)도 프로젝트별 Jira Secret과 project key가 필요하므로 기본값은 수동 실행입니다. 이슈 생성 시 자동 Jira 티켓/브랜치 생성을 원하면 해당 파일의 `issues.opened` 트리거 주석을 해제하고 `project` 값을 교체하세요.
