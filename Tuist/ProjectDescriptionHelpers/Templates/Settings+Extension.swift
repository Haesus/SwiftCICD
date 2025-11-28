//
//  Settings+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription
import UtilityPlugin

// MARK: - Settings Factory Helpers
// 프로젝트/타겟/패키지 설정을 빌드 환경(dev/release/beta)에 맞게 자동 구성하는 확장
extension ProjectDescription.Settings {
  /// 프로젝트 전역 설정 생성
  /// xcconfig가 전달되면 해당 파일을 Debug/Release 모두에 연결함
  /// - Parameter xcconfig: 프로젝트 공통으로 적용할 xcconfig 파일 경로. 전달되면 DEV/RELEASE/BETA 모든 Configuration에 동일하게 연결됨.
  /// - Returns: DEV/RELEASE/BETA 세 가지 빌드 구성을 포함한 프로젝트 전역 Settings 객체.
  public static func projectSettings(xcconfig: Path? = nil) -> Self {
    let devConfig = BuildConfiguration.dev
    let releaseConfig = BuildConfiguration.release
    let betaConfig = BuildConfiguration.beta
    
    return .settings(
      configurations: [
        .debug(
          name: devConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(devConfig.name)"])
            .swiftActiveCompilationConditions([devConfig.name, "DEBUG"])
          ,
          xcconfig: xcconfig
        ),
        .release(
          name: releaseConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(releaseConfig.name)"])
            .swiftActiveCompilationConditions([releaseConfig.name])
          ,
          xcconfig: xcconfig
        ),
        .release(
          name: betaConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(betaConfig.name)"])
            .swiftActiveCompilationConditions([betaConfig.name])
          ,
          xcconfig: xcconfig
        )
      ],
      defaultSettings: .none
    )
  }
  
  /// 타겟별 설정 생성
  /// 대상 Product(iOS App, Framework 등)에 따라 각 타겟 전용 xcconfig 자동 연결
  /// - Parameter product: iOS App, Framework 등 타겟의 Product 타입. 제품 타입에 따라 자동으로 타겟 전용 xcconfig를 선택하여 연결함.
  /// - Returns: DEV/RELEASE/BETA 각 구성에 대해 제품 타입별 xcconfig가 적용된 타겟 전용 Settings 객체.
  public static func targetSettings(product: Product) -> Self {
    let devConfig = BuildConfiguration.dev
    let releaseConfig = BuildConfiguration.release
    let betaConfig = BuildConfiguration.beta
    
    return .settings(
      configurations: [
        .debug(
          name: devConfig.configurationName,
          xcconfig: .targetXCConfig(type: product)
        ),
        .release(
          name: releaseConfig.configurationName,
          xcconfig: .targetXCConfig(type: product)
        ),
        .release(
          name: betaConfig.configurationName,
          xcconfig: .targetXCConfig(type: product)
        )
      ],
      defaultSettings: .none
    )
  }
  
  /// Swift Package용 설정
  /// 시뮬레이터 빌드 호환성을 위해 x86_64 아키텍처 제외
  public static var packageSettings: Self {
    let devConfig = BuildConfiguration.dev
    let releaseConfig = BuildConfiguration.release
    let betaConfig = BuildConfiguration.beta
    
    return .settings(
      base: [
        "EXCLUDED_ARCHS[sdk=iphonesimulator*]": "x86_64"
      ],
      configurations: [
        .debug(name: devConfig.configurationName),
        .release(name: releaseConfig.configurationName),
        .release(name: betaConfig.configurationName)
      ],
      defaultSettings: .essential
    )
  }
}
