import Foundation

final class MatchesModuleBuilder {
    let viewControler: MatchesModuleViewController
    private let presenter: MatchesModulePresenter
    var output: MatchesModuleOutput {
        presenter.output
    }
    var input: MatchesModuleInput {
        presenter
    }
    
    init(output: MatchesModuleOutput, matchesService: MatchesService) {
        presenter = MatchesModulePresenter(matchesService: matchesService, output: output)
        viewControler = MatchesModuleViewController(output: presenter)
        presenter.view = viewControler
    }
}
