//
//  Project.swift
//  FeatureManifests
//
//  Created by 윤해수 on <#mm/dd/yy#>.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.MainFeature,
  scripts: [],
  targets: [
    .sources,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Shared.self)
    ]
  ]
)
