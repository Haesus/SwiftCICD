//
//  InfoPlist+Example.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

extension InfoPlist {
  public enum Example {
    public static func app(name: String) -> InfoPlist {
      return .dictionary(
        [
          // MARK: - Environment Value
          // 환경별로 달라지는 API 엔드포인트
          "BASE_URL": "$(BASE_URL)",
          
          // MARK: - Core Foundation
          // 기본 지역 설정
          "CFBundleDevelopmentRegion": "ko_KR",
          // 홈 화면에 표시될 앱 이름
          "CFBundleDisplayName": "\(name)",
          // 실행 가능한 바이너리 이름
          "CFBundleExecutable": "$(EXECUTABLE_NAME)",
          // 번들 식별자
          "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
          // Info.plist 포맷 버전
          "CFBundleInfoDictionaryVersion": "6.0",
          // 시스템 내부에서 사용하는 앱 이름
          "CFBundleName": "\(name)",
          // 패키지 타입(APPL = 앱)
          "CFBundlePackageType": "APPL",
          // 사용자에게 표시되는 버전
          "CFBundleShortVersionString": "1.0.0",
          // 빌드 번호
          "CFBundleVersion": "1",
          
          // MARK: - Launch Services
          // 앱이 iOS가 반드시 필요함
          "LSRequiresIPhoneOS": true,
          
          // MARK: - Cocoa
          // 네트워크 통신 보안 설정
          "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
          ],
          // Bonjour 서비스 탐색
          "NSBonjourServices": [
            "_dartobservatory._tcp"
          ],
          // 카메라 접근 권한 안내
          "NSCameraUsageDescription": "앱이 디바이스의 카메라에 액세스할 수 있는 이유를 지정합니다.",
          // 연락처 접근 권한 안내
          "NSContactsUsageDescription": "앱이 사용자의 연락처에 액세스하는 이유를 지정합니다.",
          // 위치 정보 접근 권한 안내
          "NSLocationWhenInUseUsageDescription": "앱이 사용 중인 동안 앱이 사용자의 위치 정보에 액세스할 수 있는 이유를 지정합니다.",
          // 사진 접근 권한 안내
          "NSPhotoLibraryUsageDescription": "앱이 사용자의 사진 라이브러리에 액세스할 수 있는 이유를 지정합니다.",
          // 광고 추적 권한 안내
          "NSUserTrackingUsageDescription": "앱이 사용자 또는 디바이스 추적을 위해 데이터 사용 권한을 요청하는 이유를 지정합니다.",
          // 마이크 접근 권한 안내
          "NSMicrophoneUsageDescription": "앱이 기기의 마이크에 액세스할 수 있는 이유를 지정합니다.",
          
          // MARK: - UIKit
          // 런치 스크린 설정
          "UILaunchStoryboardName": "LaunchScreen",
          // 앱에서 사용하는 커스텀 폰트 목록
          "UIAppFonts": [
            "Pretendard-Bold.otf",
            "Pretendard-Medium.otf",
            "Pretendard-Regular.otf",
            "Pretendard-SemiBold.otf"
          ]
        ]
      )
    }
  }
}
