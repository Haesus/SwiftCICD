//
//  Project.swift
//  FeatureManifests
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project: Project = .makeProject(
  module: Shared.ThirdParty_SPM,
  includeResource: false,
  scripts: [],
  product: .framework,
  dependencies: [
//    TargetDependency.SPMTarget.composableArchitecture,
//    TargetDependency.SPMTarget.dependencies,
//    TargetDependency.SPMTarget.alamofire,
//    TargetDependency.SPMTarget.jwtDecode
  ]
)
