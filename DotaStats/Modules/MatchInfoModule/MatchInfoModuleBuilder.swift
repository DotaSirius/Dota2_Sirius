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
    
    init(output: MatchInfoModuleOutput, networkService: NetworkService) {
        presenter = MatchInfoModulePresenter(networkService: networkService, output: output)
        viewControler = MatchInfoViewController(output: presenter)
        //presenter.view = viewControler
    }
}
