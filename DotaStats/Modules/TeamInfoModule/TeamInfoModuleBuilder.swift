import Foundation

final class TeamInfoModuleBuilder {
    let viewController: TeamInfoModuleViewController
    private let presenter: TeamInfoModulePresenter
    var output: TeamInfoModuleOutput {
        presenter.output
    }
    var input: TeamInfoModuleInput {
        presenter
    }

    init(converter: TeamInfoConverter, output: TeamInfoModuleOutput, teamInfoService: TeamInfoService, teamId: Int) {
        presenter = TeamInfoModulePresenter(
            converter: converter,
            teamInfoService: teamInfoService,
            output: output,
            teamId: 15
        )
        viewController = TeamInfoModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
