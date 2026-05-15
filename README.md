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

## Template Validation

새 프로젝트에 이 템플릿을 복사한 뒤에는 먼저 설정값이 모두 교체됐는지 검사하세요.

```bash
make validate_template_setup
```

이 명령은 아래 항목을 확인합니다.

- `YOUR_TEAM_ID`, `YOUR_ITC_TEAM_ID` 같은 Team ID placeholder
- `com.company.app`, `developer@example.com`, `your-org` 같은 예시 값
- `AppEnv.swift`, `Xcconfig/Project/*.xcconfig`, `fastlane/*` 필수 설정 파일 존재 여부

현재 저장소는 템플릿 자체라 placeholder가 남아 있는 것이 정상입니다. 템플릿 저장소에서 스크립트 동작만 확인할 때는 아래 옵션을 사용하세요.

```bash
scripts/validate_template_setup.sh --allow-template-placeholders
```

새 프로젝트에서는 이 옵션을 사용하지 않는 것을 권장합니다. placeholder가 남아 있으면 빌드나 TestFlight 배포 전에 값을 교체해야 합니다.

## CI Preflight

`TestFlight CI` workflow는 첫 단계에서 preflight 검사를 실행합니다.

preflight는 아래 두 가지를 먼저 확인합니다.

- TestFlight 배포에 필요한 GitHub Secrets가 비어 있지 않은지
- `scripts/validate_template_setup.sh` 기준으로 template placeholder가 남아 있지 않은지

필수 Secret이 누락되면 workflow 초반에 `Missing GitHub Secret` 에러로 실패합니다. 이 경우 `.github/workflows/testflight-ci.yml`과 README의 GitHub Secrets 표를 기준으로 값을 채우면 됩니다.

placeholder 검사에서 실패하면 `Initial Setup Checklist`의 파일별 교체값을 먼저 반영하세요.

## Initial Setup Checklist

새 프로젝트로 사용할 때는 이 저장소를 복사한 뒤 아래 값을 먼저 교체하세요. 각 파일에도 `TODO` 주석을 남겨 두었습니다.

민감 정보는 코드에 직접 넣지 말고 GitHub Secrets, Keychain, 앱 설정 화면 같은 외부 주입 방식을 사용하세요.

### 1. 프로젝트 이름과 번들 ID

`Tuist/ProjectDescriptionHelpers/AppEnv.swift`

| 값 | 설명 | 예시 |
| --- | --- | --- |
| `organizationName` | Xcode project organization name | `MyCompany` |
| DEV `bundleId` | 개발용 앱 번들 ID | `com.mycompany.myapp.dev` |
| BETA `bundleId` | TestFlight/베타용 앱 번들 ID | `com.mycompany.myapp.beta` |
| RELEASE `bundleId` | App Store 릴리즈용 앱 번들 ID | `com.mycompany.myapp` |

`Xcconfig/Project/dev.xcconfig`, `beta.xcconfig`, `release.xcconfig`

| 값 | 설명 | 예시 |
| --- | --- | --- |
| `DEVELOPMENT_TEAM` | Apple Developer Team ID | `1ABC2D345E` |
| `APP_NAME` | 홈 화면에 표시할 앱 이름 | `DEV_MyApp`, `BETA_MyApp`, `MyApp` |
| `MARKETING_VERSION` | 앱 버전 | `1.0.0` |
| `CURRENT_PROJECT_VERSION` | 빌드 번호 | `1` |

### 2. App Store Connect / Apple Developer 준비

새 프로젝트마다 Apple Developer와 App Store Connect에서 아래 항목을 직접 만들어야 합니다.

| 항목 | 설명 |
| --- | --- |
| App ID | DEV/BETA/RELEASE 번들 ID별로 등록합니다. |
| App Store Connect App | RELEASE 앱 기준으로 생성합니다. |
| App Store Connect API Key | GitHub Actions에서 TestFlight 업로드에 사용합니다. |
| Certificates / Profiles | `fastlane match` 저장소에 저장할 인증서와 프로비저닝 프로파일입니다. |
| match 인증서 저장소 | private repository를 권장합니다. 예: `git@github.com:my-org/certificates-ios.git` |

### 3. fastlane 설정

`fastlane/Appfile`

| 값 | 설명 |
| --- | --- |
| `APP_IDENTIFIER_RELEASE` | RELEASE 번들 ID입니다. `AppEnv.swift`의 RELEASE 값과 같아야 합니다. |
| `FASTLANE_APPLE_ID` | Apple Developer/App Store Connect 계정 이메일입니다. |
| `FASTLANE_ITC_TEAM_ID` | App Store Connect Team ID입니다. 숫자형 ID입니다. |
| `DEVELOPMENT_TEAM` | Apple Developer Team ID입니다. `Xcconfig/Project/*.xcconfig`와 같아야 합니다. |

`fastlane/Matchfile`

| 값 | 설명 |
| --- | --- |
| `MATCH_GIT_URL` 또는 `MATCH_GIT_URL_SSH` | match 인증서 저장소 URL입니다. CI에서는 SSH 방식을 권장합니다. |
| `MATCH_GIT_BRANCH` | 인증서 저장소 브랜치입니다. 기본값은 `master`입니다. |
| `APP_IDENTIFIER_RELEASE` | RELEASE 번들 ID입니다. |
| `APP_IDENTIFIER_BETA` | BETA 번들 ID입니다. |
| `APP_IDENTIFIER_DEV` | DEV 번들 ID입니다. |
| `FASTLANE_APPLE_ID` | match가 Apple Developer Portal에 접근할 때 사용하는 계정 이메일입니다. |

`fastlane/Fastfile`

| 값 | 설명 |
| --- | --- |
| `TUIST_BUILD_CONFIG` | `DEV`, `BETA`, `RELEASE` 중 하나입니다. CI 기본값은 `BETA`입니다. |
| `APP_IDENTIFIER_DEV` | DEV 빌드에서 사용할 번들 ID입니다. |
| `APP_IDENTIFIER_BETA` | BETA 빌드에서 사용할 번들 ID입니다. |
| `APP_IDENTIFIER_RELEASE` | RELEASE 빌드에서 사용할 번들 ID입니다. |

### 4. GitHub Secrets

`.github/workflows/testflight-ci.yml`에서 사용하는 Secrets입니다.

| Secret | 설명 |
| --- | --- |
| `ASC_KEY_ID` | App Store Connect API Key ID |
| `ASC_ISSUER_ID` | App Store Connect Issuer ID |
| `ASC_API_KEY_BASE64` | `.p8` API key 파일 내용을 base64로 인코딩한 값 |
| `API_BASE_URL` | 앱에서 사용할 API base URL입니다. 필요 없으면 비워도 됩니다. |
| `FASTLANE_APPLE_ID` | Apple Developer/App Store Connect 계정 이메일 |
| `FASTLANE_ITC_TEAM_ID` | App Store Connect Team ID |
| `DEVELOPMENT_TEAM` | Apple Developer Team ID |
| `APP_IDENTIFIER_RELEASE` | RELEASE 번들 ID |
| `APP_IDENTIFIER_BETA` | BETA 번들 ID |
| `APP_IDENTIFIER_DEV` | DEV 번들 ID |
| `MATCH_GIT_URL` | match 인증서 저장소 HTTPS URL입니다. SSH만 쓰면 생략할 수 있습니다. |
| `MATCH_GIT_URL_SSH` | match 인증서 저장소 SSH URL입니다. 예: `git@github.com:my-org/certificates-ios.git` |
| `MATCH_USERNAME` | match/Apple Developer 계정 이메일입니다. 필요 없으면 `FASTLANE_APPLE_ID`와 같은 값을 사용합니다. |
| `MATCH_PASSWORD` | match 인증서 저장소 암호화 비밀번호입니다. |
| `MATCH_KEYCHAIN_PASSWORD` | CI 임시 keychain 비밀번호입니다. 임의의 강한 값으로 설정합니다. |
| `MATCH_SSH_PRIVATE_KEY` | match 저장소 Deploy Key private key를 base64로 인코딩한 값 |

`MATCH_SSH_PRIVATE_KEY`는 아래처럼 만들 수 있습니다.

```bash
base64 -i ~/.ssh/id_ed25519 -o match_ssh_private_key.base64
```

생성된 파일 내용을 GitHub Secrets에 넣고, public key는 match 인증서 저장소의 Deploy Key로 등록하세요.

### 5. 워크플로 활성화

`TestFlight CI`는 초기 템플릿 상태에서 비밀값 없이 자동 실패하지 않도록 수동 실행(`workflow_dispatch`)만 켜 두었습니다. `main` 머지 시 자동 배포가 필요하면 `.github/workflows/testflight-ci.yml`의 `push` 트리거 주석을 해제하세요.

Jira 연동 워크플로(`auto-connect-jira.yml`)도 프로젝트별 Jira Secret과 project key가 필요하므로 기본값은 수동 실행입니다. 이슈 생성 시 자동 Jira 티켓/브랜치 생성을 원하면 해당 파일의 `issues.opened` 트리거 주석을 해제하고 `project` 값을 교체하세요.

Jira 연동을 사용할 때 추가로 필요한 값입니다.

| 값 | 설명 |
| --- | --- |
| `JIRA_BASE_URL` | Jira workspace URL입니다. 예: `https://mycompany.atlassian.net` |
| `JIRA_USER_EMAIL` | Jira 계정 이메일입니다. |
| `JIRA_API_TOKEN` | Jira API token입니다. |
| `project` | `.github/workflows/auto-connect-jira.yml`의 Jira project key입니다. 예: `ABC` |

### 6. 복사 후 검증 순서

새 프로젝트에 붙인 뒤 아래 순서로 확인하세요.

```bash
make install
make validate_template_setup
TUIST_BUILD_CONFIG=dev tuist generate
xcodebuild -workspace SwiftCICD.xcworkspace -scheme SwiftCICD_DEV -configuration DEV -destination 'generic/platform=iOS Simulator' build
```

`make validate_template_setup`은 `YOUR_TEAM_ID`, `com.company.app`, `developer@example.com` 같은 template placeholder가 남아 있는지 검사합니다. 이 템플릿 저장소 자체에서 스크립트 동작만 확인할 때는 아래 옵션을 사용할 수 있습니다.

```bash
scripts/validate_template_setup.sh --allow-template-placeholders
```

로컬 빌드가 통과하면 GitHub Secrets를 등록한 뒤 Actions에서 `TestFlight CI`를 수동 실행하세요. workflow 첫 단계의 preflight가 필수 Secret과 남은 placeholder를 먼저 검사합니다. 수동 실행이 성공한 뒤에만 `push` 자동 배포 트리거를 켜는 것을 권장합니다.

### 7. 이름 변경 시 추가 확인

프로젝트 이름 자체를 `SwiftCICD`에서 새 이름으로 바꾸고 싶다면 아래 경로도 함께 확인하세요.

| 위치 | 확인 내용 |
| --- | --- |
| `Workspace.swift` | workspace 이름과 포함 project 경로 |
| `Projects/App/SwiftCICD` | 앱 타겟 폴더명 |
| `Projects/App/SwiftCICD/Project.swift` | target name, scheme name |
| `Makefile` | `make dev`, `make beta`, `make release`에서 호출하는 설정 |
| `README.md` | 예시 명령의 workspace/scheme 이름 |

이름 변경은 필수는 아닙니다. 새 레포에서 내부 target/workspace 이름을 유지해도 번들 ID, 앱 이름, Team ID만 맞으면 빌드와 배포 흐름은 사용할 수 있습니다.
