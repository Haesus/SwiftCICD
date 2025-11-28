//
//  Target+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription
import UtilityPlugin

extension Target {
  // MARK: - Target Factory
  /// 공통 Target 생성 함수
  /// 모듈별 Sources/Resources/Scripts/Dependencies 등을 한 번에 설정하기 위한 헬퍼
  /// - Parameters:
  ///   - name: 타겟 이름 (예: AuthFeature, CoreNetwork 등 모듈 단위의 식별자).
  ///   - product: 생성할 타겟의 Product 타입(app, framework, staticLibrary 등).
  ///   - infoPlist: 타겟에 적용할 Info.plist 정의(커스텀 또는 자동 생성).
  ///   - sources: 타겟이 포함할 소스 코드 파일 경로 목록.
  ///   - resources: 번들에 포함할 리소스 파일 목록(Assets, Storyboard, XIB 등). 없으면 nil.
  ///   - scripts: 빌드 전/후에 실행할 빌드 스크립트(SwiftLint, SwiftGen 등).
  ///   - dependencies: 다른 Target 또는 Swift Package에 대한 의존성 목록.
  ///   - coreDataModels: 타겟에서 사용할 Core Data 모델(.xcdatamodeld) 배열.
  /// - Returns: 전달된 설정을 기반으로 생성된 Target 인스턴스.
  static func target(
    name: String,
    product: Product,
    infoPlist: InfoPlist,
    sources: SourceFilesList,
    resources: ResourceFileElements?,
    scripts: [TargetScript],
    dependencies: [TargetDependency],
    coreDataModels: [CoreDataModel] = []
  ) -> Target {
    return .target(
      name: name,
      destinations: AppEnv.platform,
      product: product,
      productName: nil,
      bundleId: AppEnv.moduleBundleId(name: name),
      deploymentTargets: AppEnv.deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      copyFiles: nil,
      headers: nil,
      entitlements: nil,
      scripts: scripts,
      dependencies: dependencies,
      settings: .targetSettings(product: product),
      coreDataModels: coreDataModels,
      environmentVariables: [:],
      launchArguments: [],
      additionalFiles: [],
      buildRules: []
    )
  }
}
