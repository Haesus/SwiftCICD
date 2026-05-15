import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeRootProject(
  rootModule: Domain.self,
  scripts: [],
  product: .staticLibrary
)
