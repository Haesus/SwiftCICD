//
//  Scheme+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription
import UtilityPlugin

// MARK: - Scheme Factory Helpers
// 앱 및 익스텐션 실행/빌드 스킴을 자동 생성하기 위한 확장
extension Scheme {
  /// 앱 타겟을 위한 실행 스킴 생성
  /// 환경별(dev/prod)로 다른 RunAction 설정을 적용함
  /// - Parameters:
  ///   - target: 실행 및 빌드 스킴을 생성할 대상 앱 타겟.
  ///   - config: 스킴이 적용될 빌드 구성(dev / beta / release).
  /// - Returns: 지정된 앱 타겟과 환경 설정을 기반으로 생성된 Scheme 객체.
  public static func makeAppScheme(target: TargetReference, config: BuildConfiguration) -> Scheme {
    var runAction: RunAction
    
    switch config {
      case .dev:
        runAction = .runAction(
          configuration: config.configurationName,
          executable: target,
          arguments: .arguments(
            environmentVariables: [
              "OS_ACTIVITY_MODE": .environmentVariable(value: "enable", isEnabled: true),
              "IDEPreferLogStreaming": .environmentVariable(value: "YES", isEnabled: true)
            ]
          )
        )
        
      case .release:
        runAction = .runAction(configuration: config.configurationName, executable: target)
        
      case .beta:
        runAction = .runAction(configuration: config.configurationName, executable: target)
    }
    
    return .scheme(
      name: "\(target.targetName)_\(config.name)",
      shared: true,
      buildAction: .buildAction(targets: [target]),
      runAction: runAction,
      archiveAction: .archiveAction(configuration: config.configurationName),
      profileAction: .profileAction(configuration: config.configurationName, executable: target),
      analyzeAction: .analyzeAction(configuration: config.configurationName)
    )
  }
  
  /// 앱 확장(Extension) 타겟을 위한 스킴 생성
  /// 확장과 본체 앱을 함께 빌드해야 하므로 buildAction에 두 타겟 모두 포함
  /// - Parameters:
  ///   - extensionTarget: 실행 스킴을 생성할 확장(Extension) 타겟.
  ///   - appTarget: 확장과 함께 빌드해야 하는 메인 앱 타겟.
  ///   - config: 스킴이 적용될 빌드 구성(dev / beta / release).
  /// - Returns: 확장 타겟과 앱 타겟을 함께 빌드하도록 구성된 Scheme 객체.
  public static func makeExtensionScheme(extensionTarget: TargetReference, appTarget: TargetReference, config: BuildConfiguration) -> Scheme {
    return .scheme(
      name: extensionTarget.targetName,
      shared: true,
      buildAction: .buildAction(targets: [extensionTarget, appTarget]),
      runAction: .runAction(configuration: config.configurationName),
      archiveAction: .archiveAction(configuration: config.configurationName),
      profileAction: .profileAction(configuration: config.configurationName),
      analyzeAction: .analyzeAction(configuration: config.configurationName)
    )
  }
}
