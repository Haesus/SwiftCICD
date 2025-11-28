//
//  TargetScript+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import Foundation
import ProjectDescription
import UtilityPlugin

public extension TargetScript {
  // MARK: - Reveal 스크립트
  /// Reveal 디버깅 도구 연동 스크립트 생성
  /// - Note: BuildConfiguration 별로 환경변수를 재정의해야 하므로 target.name을 포함하여 스크립트 생성
  /// - Parameter target: Reveal 스크립트가 적용될 빌드 구성(Debug / Release / Beta 등).
  /// - Returns: 지정된 빌드 구성에 맞춰 Reveal 서버 로딩을 수행하는 TargetScript 인스턴스.
  static func reveal(target: BuildConfiguration) -> TargetScript {
    return .pre(
      script: """
      # 현재 Configuration(Debug/Release 등)에 맞게 Reveal 로딩 설정
      REVEAL_LOAD_FOR_CONFIGURATION=\(target.name)
      export REVEAL_LOAD_FOR_CONFIGURATION
      
      # Reveal 앱의 설치 경로를 Spotlight(mdfind)로 검색
      REVEAL_APP_PATH=$(mdfind kMDItemCFBundleIdentifier="com.ittybittyapps.Reveal2" | head -n 1)
      
      # Reveal 앱 내부에 포함된 서버 스크립트 경로
      BUILD_SCRIPT_PATH="${REVEAL_APP_PATH}/Contents/SharedSupport/Scripts/reveal_server_build_phase.sh"
      
      # Reveal 앱과 빌드 스크립트 존재 여부 확인
      if [ "${REVEAL_APP_PATH}" -a -e "${BUILD_SCRIPT_PATH}" ]; then
        "${BUILD_SCRIPT_PATH}"
      # Reveal 앱을 찾지 못한 경우 경고 출력
      else
        echo "Reveal Server not loaded: Cannot find a compatible Reveal app."
      fi
      """,
      name: "Reveal",
      basedOnDependencyAnalysis: false
    )
  }
}
