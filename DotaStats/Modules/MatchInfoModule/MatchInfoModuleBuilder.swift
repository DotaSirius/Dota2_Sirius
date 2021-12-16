import Foundation

final class MatchInfoModuleBuilder {
    let viewControler: MatchInfoViewController
    private let presenter:  MatchInfoModulePresenter
    var output:  MatchInfoModuleOutput {
        presenter.output
    }
    var input:  MatchInfoModuleInput {
        presenter
    }

    init(output: MatchInfoModuleOutput, networkService: MatchDetailService, converter: MatchInfoConverter) {
        self.presenter = MatchInfoModulePresenter(converter: converter, output: output, networkService: networkService)
        self.viewControler = MatchInfoViewController(output: presenter)
        self.presenter.view = viewControler
    }
}