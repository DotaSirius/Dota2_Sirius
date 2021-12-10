import Foundation

final class PlayersModule {
    let output: PlayersModuleOutput
    let input: PlayersModuleInput
    let viewControler: PlayersModuleViewController
    
    init(output: PlayersModuleOutput, networkService: NetworkService) {
        self.output = output
        let presenter = PlayersModulePresenter(networkService: networkService)
        input = presenter
        viewControler = PlayersModuleViewController(output: presenter)
        presenter.view = viewControler
    }
}
