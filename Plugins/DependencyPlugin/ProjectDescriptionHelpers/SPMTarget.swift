//
//  SPMTarget.swift
//  DependencyPlugin
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

public extension TargetDependency {
  // SPM 패키지 의존성들을 한 곳에 모아 관리하기 위한 확장입니다.
  // TargetDependency.SPMTarget 내부에 각 Swift Package Manager 의존성을 static 프로퍼티로 정의하여
  // Project.swift에서 `.SPMTarget.xxx` 형태로 간단하고 안전하게 가져다 쓸 수 있도록 구성한 파일입니다.
  enum SPMTarget {
    // TCA (The Composable Architecture) 패키지 의존성
    // 모듈에서 .external(name: "ComposableArchitecture")를 반복 입력하지 않도록 추상화한 프로퍼티입니다.
    public static let composableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
    
    // Point-Free Dependencies 패키지 (의존성 주입 시스템)
    // 프로젝트 전역에서 DI 기능을 통일되게 사용하기 위한 패키지 등록입니다.
    public static let dependencies: TargetDependency = .external(name: "Dependencies")
    
    // 네트워크 통신 라이브러리 Alamofire 의존성
    // HTTP 요청 및 응답 처리를 간단하게 하기 위한 외부 패키지를 참조합니다.
    public static let alamofire: TargetDependency = .external(name: "Alamofire")
    
    public static let jwtDecode: TargetDependency = .external(name: "JWTDecode")
  }
}
