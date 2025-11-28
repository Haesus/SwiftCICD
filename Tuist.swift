// Tuist의 전역 설정 파일로, 프로젝트 전체에서 공통으로 사용하는 플러그인 및 설정을 정의하는 파일
// 이 파일은 Tuist가 프로젝트를 생성(generation)할 때 가장 먼저 읽는 엔트리포인트 역할
//

//  Tuist.swift
//  Tuist
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription

let config = Config(
  // 프로젝트 전역에서 사용할 플러그인을 등록
  project: .tuist(
    // .local(path: ...)은 루트 디렉토리 기준으로 플러그인을 로드
    plugins: [
      .local(path: .relativeToRoot("Plugins/UtilityPlugin")),
      .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ],
    generationOptions: .options(disableSandbox: true)
  )
)
