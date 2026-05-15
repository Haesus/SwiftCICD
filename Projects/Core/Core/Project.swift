import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeRootProject(
  rootModule: Core.self,
  scripts: [],
  product: .staticLibrary
)
