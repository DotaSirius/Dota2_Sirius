import Foundation

final class TeamsModuleBuilder {
    let viewController: TeamsModuleViewController
    private let presenter: TeamsModulePresenter
    var output: TeamsModuleOutput {
        presenter.output
    }

    var input: TeamsModuleInput {
        presenter
    }

    init(output: TeamsModuleOutput, teamsService: TeamsService) {
        presenter = TeamsModulePresenter(teamsService: teamsService, output: output)
        viewController = TeamsModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
