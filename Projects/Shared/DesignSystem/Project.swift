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
  module: Shared.DesignSystem,
  options: .options(
    disableSynthesizedResourceAccessors: false
  ),
  includeResource: true,
  scripts: [],
  targets: [
    .sources,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(module: Shared.Utils)
    ]
  ],
  resourceSynthesizers: [
    .fonts(),
    .assets()
  ]
)
