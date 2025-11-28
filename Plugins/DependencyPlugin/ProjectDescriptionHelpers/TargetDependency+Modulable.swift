//
//  TargetDependency+Modulable.swift
//  DependencyPlugin
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

public protocol Modulable: CaseIterable {
  var path: String { get }
}

extension Modulable where Self: RawRepresentable, Self.RawValue == String {
  public var path: String {
    return "\(Self.self)/\(self.rawValue)"
  }
}

extension TargetDependency {
  /// Modulable 모듈 의존성 연결
  /// - Parameters:
  ///   - module: 의존성을 연결할 Modulable 모듈(enum). 모듈 경로와 Target 이름 생성에 사용됨.
  ///   - target: 연결할 타겟 타입(.sources 또는 .interface). 기본값은 .sources.
  /// - Returns: 지정된 모듈과 타겟 타입에 해당하는 TargetDependency 객체.
  public static func dependency<T: Modulable>(module: T, target: TargetType = .sources) -> TargetDependency {
    let moduleName = String(describing: module)
    return .project(target: "\(moduleName)\(target.suffixName)", path: .relativeToRoot("Projects/\(module.path)"))
  }
  
  /// Modulable 루트 의존성 연결
  /// - Parameter rootModule: 루트 모듈(enum) 타입. 모듈 전체(Sources/Interface)를 루트 기준으로 의존성 연결할 때 사용됨.
  /// - Returns: 루트 모듈 경로를 기반으로 생성된 TargetDependency 객체.
  public static func dependency<T: Modulable>(rootModule: T.Type) -> TargetDependency {
    let moduleName = String(describing: rootModule)
    return .project(target: "\(moduleName)", path: .relativeToRoot("Projects/\(moduleName)/\(moduleName)"))
  }
  
  public enum TargetType: Hashable {
    case sources
    case interface
    
    public var suffixName: String {
      switch self {
      case .sources:
        return ""
      case .interface:
        return "Interface"
      }
    }
  }
}
