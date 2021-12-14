import Foundation

final class MatchesModuleBuilder {
    let viewController: MatchesModuleViewController
    private let presenter: MatchesModulePresenter
    var output: MatchesModuleOutput {
        presenter.output
    }
    var input: MatchesModuleInput {
        presenter
    }
    
    init(output: MatchesModuleOutput, matchesService: MatchesService) {
        presenter = MatchesModulePresenter(matchesService: matchesService, output: output)
        viewController = MatchesModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
