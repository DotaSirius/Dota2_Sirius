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
    
    init(output: MatchesModuleOutput, networkService: NetworkService) {
        presenter = MatchesModulePresenter(networkService: networkService, output: output)
        viewControler = MatchesModuleViewController(output: presenter)
        presenter.view = viewControler
    }
}
