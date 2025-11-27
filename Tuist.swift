// Tuist의 전역 설정 파일로, 프로젝트 전체에서 공통으로 사용하는 플러그인 및 설정을 정의하는 파일입니다.
// 이 파일은 Tuist가 프로젝트를 생성(generation)할 때 가장 먼저 읽는 엔트리포인트 역할을 합니다.
//

//  Tuist.swift
//  Tuist
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

// Config는 Tuist의 전역 설정을 정의하는 객체입니다.
// 최신 Tuist에서는 프로젝트 관련 설정을 project: .tuist(...) 형태로 감싸는 것이 권장 방식입니다.
let config = Config(
  // project: .tuist(...)는 전체 프로젝트의 공통 Tuist 설정을 캡슐화하는 부분입니다.
  // 여기서는 프로젝트 전역에서 사용할 플러그인을 등록하고 있습니다.
  project: .tuist(
    // plugins: 프로젝트 전역(Global)으로 적용되는 Tuist 플러그인 목록입니다.
    // .local(path: ...)은 루트 디렉토리 기준으로 플러그인을 로드합니다.
    plugins: [
      .local(path: .relativeToRoot("Plugins/UtilityPlugin")),
      .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ],
    generationOptions: .options(disableSandbox: true)
  )
)
