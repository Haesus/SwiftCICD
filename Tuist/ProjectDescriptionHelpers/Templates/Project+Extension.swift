//
//  Project+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import DependencyPlugin
import ProjectDescription
import UtilityPlugin

// MARK: - Project factory helpers for TMA-based modular architecture
extension Project {
  /// TMA 구조(Modulable 모듈)를 기반으로
  /// Sources / Interface / Tests / Testing / Example 타겟들을 한 번에 생성하는 Project 팩토리 메서드
  /// - Parameters:
  ///   - module: Modulable을 준수하는 모듈 식별자(enum 또는 타입). 모듈 이름 및 타겟 기본 이름으로 사용됨.
  ///   - options: 프로젝트 전역 옵션(Tuist의 Project.Options). 기본적으로 리소스 자동 액세스 코드를 비활성화.
  ///   - packages: 프로젝트에서 사용할 Swift 패키지 목록.
  ///   - infoPlist: 각 타겟에 공통으로 적용할 Info.plist 정의. 필요 시 개별 타겟에서 재정의 가능.
  ///   - includeResource: `Resources/**` 경로를 리소스로 포함할지 여부. true일 경우 리소스가 포함된 정적 프레임워크/라이브러리로 생성.
  ///   - scripts: 각 타겟에 공통으로 적용할 빌드 스크립트(SwiftLint, SwiftGen 등).
  ///   - targets: 생성할 타겟 역할 집합. `.sources`, `.interface`, `.tests`, `.testing`, `.example` 등을 조합해서 전달.
  ///   - dependencies: 각 TargetType별로 부여할 타겟/패키지 의존성 맵.
  ///   - coreDataModels: Core Data 모델(.xcdatamodeld)을 사용하는 경우 연결할 모델 배열.
  ///   - schemes: 프로젝트에 추가할 스킴 목록. 필요 시 Example/Tests용 스킴 등을 함께 정의.
  ///   - resourceSynthesizers: Asset, Strings 등 리소스를 자동으로 코드로 변환하기 위한 리소스 합성기 설정.
  /// - Returns: 전달된 TMA 모듈 구조에 맞게 Sources/Interface/Tests/Testing/Example 타겟이 구성된 Project 인스턴스.
  public static func makeTMABasedProject<T: Modulable>(
    module: T,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    includeResource: Bool = false,
    scripts: [TargetScript],
    targets: Set<TargetType>, // ex) [.sources, .interface, .tests, .testing, .example]
    dependencies: [TargetType: [TargetDependency]],
    coreDataModels: [CoreDataModel] = [],
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    let name = String(describing: module)
    var projectTargets: [Target] = []
    targets.forEach { targetType in
      let targetName = "\(name)\(targetType.suffixName)"
      let currentDependencies = dependencies[targetType] ?? []
      
      switch targetType {
        case .sources:
          let product: Product = if includeResource {
            .staticFramework // currentConfig == .dev ? .framework : .staticFramework
          } else {
            .staticLibrary // currentConfig == .dev ? .framework : .staticLibrary
          }
          let resources: ResourceFileElements? = includeResource ? ["Resources/**"] : nil
          let interfaceDependency: [TargetDependency] = targets.contains(.interface) ? [.target(name: "\(name)Interface")] : []
          let dependencies: [TargetDependency] = (interfaceDependency + currentDependencies).compactMap { $0 }
          let target: Target = .target(
            name: targetName,
            product: product,
            infoPlist: infoPlist,
            sources: ["Sources/**/*.swift"],
            resources: resources,
            scripts: scripts,
            dependencies: dependencies,
            coreDataModels: coreDataModels,
          )
          projectTargets.append(target)
          
        case .interface:
          let product: Product = .staticLibrary //currentConfig == .dev ? .framework : .staticLibrary
          let target: Target = .target(
            name: targetName,
            product: product,
            infoPlist: infoPlist,
            sources: ["Interface/**/*.swift"],
            resources: nil,
            scripts: [],
            dependencies: currentDependencies,
            coreDataModels: [],
          )
          projectTargets.append(target)
          
        case .tests:
          let sourcesDependency: [TargetDependency] = [.target(name: "\(name)")]
          let testingDependency: [TargetDependency] = targets.contains(.testing) ? [.target(name: "\(name)Testing")] : []
          let dependencies: [TargetDependency] = (sourcesDependency + testingDependency + currentDependencies).compactMap { $0 }
          let target: Target = .target(
            name: targetName,
            product: .unitTests,
            infoPlist: infoPlist,
            sources: ["Tests/**/*.swift"],
            resources: nil,
            scripts: [],
            dependencies: dependencies,
            coreDataModels: [],
          )
          projectTargets.append(target)
          
        case .testing:
          let product: Product = .staticFramework // currentConfig == .dev ? .framework : .staticFramework
          let interfaceDependency: [TargetDependency] = targets.contains(.interface) ? [.target(name: "\(name)Interface")] : []
          let dependencies: [TargetDependency] = (interfaceDependency + currentDependencies).compactMap { $0 }
          let target: Target = .target(
            name: targetName,
            product: product,
            infoPlist: infoPlist,
            sources: ["Testing/**/*.swift"],
            resources: nil,
            scripts: [],
            dependencies: dependencies,
            coreDataModels: [],
          )
          projectTargets.append(target)
          
        case .example:
          let sourcesDependency: [TargetDependency] = [.target(name: "\(name)")]
          let testingDependency: [TargetDependency] = targets.contains(.testing) ? [.target(name: "\(name)Testing")] : []
          let dependencies: [TargetDependency] = (sourcesDependency + testingDependency + currentDependencies).compactMap { $0 }
          let target: Target = .target(
            name: targetName,
            product: .app,
            infoPlist: InfoPlist.Example.app(name: targetName),
            sources: ["Example/Sources/**/*.swift"],
            resources: ["Example/Resources/**"],
            scripts: [.reveal(target: .dev)],
            dependencies: dependencies,
            coreDataModels: [],
          )
          projectTargets.append(target)
      }
    }
    
    return .init(
      name: name,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings(),
      targets: projectTargets,
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
  
  /// 단일 Modulable 모듈에 대해 하나의 Target만 생성하는 간단한 Project 팩토리 메서드
  /// - Parameters:
  ///   - module: Modulable을 준수하는 모듈 식별자. 생성될 타겟 및 프로젝트 이름으로 사용됨.
  ///   - options: 프로젝트 전역 옵션(Tuist의 Project.Options). 기본값은 리소스 자동 리소스 액세스 코드를 비활성화.
  ///   - packages: 프로젝트에서 사용할 Swift 패키지 목록.
  ///   - infoPlist: 생성되는 타겟에 적용할 Info.plist 정의.
  ///   - includeResource: `Resources/**` 경로를 리소스로 포함할지 여부. true일 경우 리소스가 포함된 타겟으로 생성.
  ///   - scripts: 타겟에 적용할 빌드 스크립트(SwiftLint, SwiftGen 등).
  ///   - product: 생성할 타겟의 Product 타입(app, framework, staticLibrary 등).
  ///   - dependencies: 타겟에 연결할 TargetDependency 목록.
  ///   - coreDataModels: 타겟에서 사용할 Core Data 모델(.xcdatamodeld) 배열.
  ///   - schemes: 프로젝트에 추가할 스킴 목록.
  ///   - resourceSynthesizers: Asset, Strings 등 리소스를 코드로 변환하기 위한 리소스 합성기 설정.
  /// - Returns: 단일 Modulable 모듈을 위한 하나의 Target으로 구성된 Project 인스턴스.
  public static func makeProject<T: Modulable>(
    module: T,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    includeResource: Bool = false,
    scripts: [TargetScript],
    product: Product,
    dependencies: [TargetDependency],
    coreDataModels: [CoreDataModel] = [],
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    let targetName = String(describing: module)
    let resources: ResourceFileElements? = includeResource ? ["Resources/**"] : nil
    let target: Target = .target(
      name: targetName,
      product: product,
      infoPlist: infoPlist,
      sources: ["Sources/**/*.swift"],
      resources: resources,
      scripts: scripts,
      dependencies: dependencies,
      coreDataModels: coreDataModels,
    )
    
    return .init(
      name: targetName,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings(),
      targets: [target],
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
  
  /// Modulable enum을 루트로 하여, 모든 케이스를 child 모듈로 두는 루트 Project 생성
  /// 각 케이스는 .dependency(module:)를 통해 하위 모듈로 연결됨
  /// - Parameters:
  ///   - rootModule: 루트 역할을 하는 Modulable enum 타입. allCases를 통해 하위 모듈 목록을 정의.
  ///   - options: 프로젝트 전역 옵션(Tuist의 Project.Options). 기본값은 리소스 자동 리소스 액세스 코드를 비활성화.
  ///   - packages: 루트 프로젝트에서 사용할 Swift 패키지 목록.
  ///   - infoPlist: 루트 타겟에 적용할 Info.plist 정의.
  ///   - scripts: 루트 타겟에 적용할 빌드 스크립트(SwiftLint, SwiftGen 등).
  ///   - product: 루트 타겟의 Product 타입(app, framework, staticLibrary 등).
  ///   - schemes: 루트 프로젝트에 추가할 스킴 목록.
  ///   - resourceSynthesizers: 리소스를 코드로 변환하기 위한 리소스 합성기 설정.
  /// - Returns: Modulable enum의 모든 케이스를 하위 모듈 의존성으로 묶어 구성한 루트 Project 인스턴스.
  public static func makeRootProject<T: Modulable>(
    rootModule: T.Type,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    scripts: [TargetScript],
    product: Product,
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  )  -> Project where T: RawRepresentable, T.RawValue == String {
    let targetName = String(describing: T.self)
    let childTargets = T.allCases
    let dependencies: [TargetDependency] = childTargets.map { .dependency(module: $0) }
    
    let target: Target = .target(
      name: targetName,
      product: product,
      infoPlist: infoPlist,
      sources: ["Sources/**/*.swift"],
      resources: nil,
      scripts: scripts,
      dependencies: dependencies
    )
    
    return .init(
      name: targetName,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings(),
      targets: [target],
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
}

extension Project {
  /// TMA 아키텍처에서 사용하는 Target의 역할 종류를 표현하는 타입
  /// Sources / Interface / Tests / Testing / Example 다섯 가지 케이스를 가짐
  public enum TargetType: Hashable {
    case sources
    case interface
    case tests
    case testing
    case example
    
    public var suffixName: String {
      switch self {
        case .sources:
          return ""
        case .interface:
          return "Interface"
        case .tests:
          return "Tests"
        case .testing:
          return "Testing"
        case .example:
          return "Example"
      }
    }
  }
}
