//
//  InfoPlist+TJRefund.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

extension InfoPlist {
  public enum TestTemplate {
    public static var app: InfoPlist {
      return .dictionary(
        [
          // MARK: - Environment
          // 환경별로 달라지는 API 주소
          "BASE_URL": "$(BASE_URL)",
          
          // MARK: - Security
          // 미국 수출 규정용 암호화 관련 플래그
          "ITSAppUsesNonExemptEncryption": false,
          
          // MARK: - Localization
          // 기본 언어/지역 설정
          "CFBundleDevelopmentRegion": "ko_KR",
          // 홈 화면에 표시될 앱 이름
          "CFBundleDisplayName": "$(APP_NAME)$(APP_ENV_CONFIG)",
          // 실행 파일 이름
          "CFBundleExecutable": "$(EXECUTABLE_NAME)",
          // 앱의 번들 ID
          "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
          // Info.plist 포맷 버전
          "CFBundleInfoDictionaryVersion": "6.0",
          // 시스템 내부에서 사용하는 앱 이름
          "CFBundleName": "$(PRODUCT_NAME)",
          // 패키지 타입(APPL = iOS 앱)
          "CFBundlePackageType": "APPL",
          // 사용자에게 표시되는 앱 버전
          "CFBundleShortVersionString": "$(MARKETING_VERSION)",
          // 빌드 번호
          "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
          
          // MARK: - Launch
          // 앱 실행에 iPhoneOS가 필요함
          "LSRequiresIPhoneOS": true,
          // 외부 앱 URL 호출 시
          "LSApplicationQueriesSchemes": [
          ],
          
          // MARK: - Network
          // ATS(App Transport Security) 및 네트워크 관련 설정
          "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
            // 특정 도메인만 열어둘 경우
//            "NSExceptionDomains": [
//              "<#yourDomain.com#>": [
//                "NSIncludesSubdomains": true,
//                "NSThirdPartyExceptionAllowsInsecureHTTPLoads": true
//              ]
//            ]
          ],
          // Bonjour 서비스 검색 설정(Flutter 개발 환경)
          "NSBonjourServices": [
            "_dartobservatory._tcp"
          ],
          
          // MARK: - Permissions
          // 필요한 경우 iOS 권한 안내 문구 활성화
          //          "NSCameraUsageDescription": "",
          //          "NSContactsUsageDescription": "",
          //          "NSLocationWhenInUseUsageDescription": "",
          //          "NSMicrophoneUsageDescription": "",
          //          "NSPhotoLibraryUsageDescription": "",
          //          "NSUserTrackingUsageDescription": "",
          
          // MARK: - UI
          // Spotlight 검색 연동 여부
          "CoreSpotlightContinuation": true,
          // 앱에서 사용되는 커스텀 폰트 목록
          "UIAppFonts": [
            "Pretendard-Bold.otf",
            "Pretendard-Medium.otf",
            "Pretendard-Regular.otf",
            "Pretendard-SemiBold.otf"
          ],
          // 앱 실행 시 표시되는 Launch Screen
          "UILaunchStoryboardName": "LaunchScreen",
          // 앱이 요구하는 장치 하드웨어 조건
          "UIRequiredDeviceCapabilities": ["armv7"],
          // 상태바 숨김 여부
          "UIStatusBarHidden": true,
          // 상태바 텍스트/아이콘 스타일
          "UIStatusBarStyle": "UIStatusBarStyleLightContent",
          // iPhone에서 지원하는 화면 회전 방향
          "UISupportedInterfaceOrientations~iphone": ["UIInterfaceOrientationPortrait"],
          // 전체 UI 스타일 (Light / Dark)
          "UIUserInterfaceStyle": "Light"
        ]
      )
    }
  }
}
