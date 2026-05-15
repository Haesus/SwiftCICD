//
//  PrivacyManifest
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on 11/19/25.
//

import ProjectDescription

extension PrivacyManifest {
  // MARK: - Privacy Manifest
  // 앱이 수집·사용하는 데이터 유형과 접근 API를 선언적으로 정의하여
  // App Store Privacy 요구사항을 충족하기 위한 매니페스트
  public static var SwiftCICD: Self {
    return .privacyManifest(
      tracking: false,
      trackingDomains: [],
      // 앱이 수집하는 데이터 유형 목록
      // 각 항목은 Apple의 Privacy Nutrition Labels 규칙에 따라 구성됨
      collectedDataTypes: [
        // 기기 식별자(Device ID) — 앱 기능을 위해 수집되며 사용자와 연결되지 않음
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeDeviceID",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": true,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        // 크래시 데이터 — 분석 및 앱 안정성 개선 목적
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeCrashData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": [
            "NSPrivacyCollectedDataTypePurposeAnalytics",
            "NSPrivacyCollectedDataTypePurposeAppFunctionality"
          ]
        ],
        // 성능 데이터 — 앱 기능 향상을 위한 일반 성능 로그
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypePerformanceData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        // 기타 진단 데이터 — 앱 기능 유지 및 문제 해결 목적
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeOtherDiagnosticData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        // 앱 상호작용 데이터 — 앱 기능 동작을 위해 필요한 사용 흐름 정보
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeProductInteraction",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        // 기타 사용 데이터 — 앱 기능 제공 목적
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeOtherUsageData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ]
      ],
      // 앱에서 접근하는 민감 API 유형
      // Apple의 민감 API(AIT) 접근 이유를 명시해야 함
      accessedApiTypes: [
        // UserDefaults 접근 — 기본 설정 저장(사유 코드 CA92.1)
        [
          "NSPrivacyAccessedAPITypeReasons": ["CA92.1"],
          "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults"
        ]
      ]
    )
  }
}
