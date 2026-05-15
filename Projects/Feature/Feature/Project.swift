import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeRootProject(
  rootModule: Feature.self,
  scripts: [],
  product: .staticLibrary
)
