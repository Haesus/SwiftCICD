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
  module: Shared.Utils,
  scripts: [],
  targets: [
    .sources
  ],
  dependencies: [:]
)
