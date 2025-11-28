//
//  SPMTarget.swift
//  DependencyPlugin
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

public extension TargetDependency {
  /// 외부라이브러리 선언부
  enum SPMTarget {
    public static let composableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
    public static let dependencies: TargetDependency = .external(name: "Dependencies")
    public static let alamofire: TargetDependency = .external(name: "Alamofire")
    public static let jwtDecode: TargetDependency = .external(name: "JWTDecode")
  }
}
