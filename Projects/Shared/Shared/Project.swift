import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeRootProject(
  rootModule: Shared.self,
  scripts: [],
  product: .staticLibrary
)
