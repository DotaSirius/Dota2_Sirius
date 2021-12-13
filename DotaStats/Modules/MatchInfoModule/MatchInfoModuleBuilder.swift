import Foundation

final class MatchInfoModuleBuilder {
    let viewControler: MatchInfoViewController
    private let presenter:  MatchInfoModulePresenter
    private let converter: MatchInfoConverter
    var output:  MatchInfoModuleOutput {
        presenter.output
    }
    var input:  MatchInfoModuleInput {
        presenter
    }
    
    init(output: MatchInfoModuleOutput, networkService: NetworkService) {
        converter = MatchInfoConverterImp(networkService: networkService)
        presenter = MatchInfoModulePresenter(converter: converter, output: output)
        viewControler = MatchInfoViewController(output: presenter)
        presenter.view = viewControler
    }
}
