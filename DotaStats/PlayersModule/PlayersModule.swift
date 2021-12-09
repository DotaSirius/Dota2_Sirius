import Foundation

class PlayersModule {
    private let view: PlayersModuleInput
    private let presenter: PlayersModuleOutput
    private let networkService: NetworkSeviceProtocol
    
    init() {
        networkService = NetworkService()
        presenter = PlayersModulePresenter(networkService: networkService)
        view = PlayerModuleViewController(presenter: presenter)
        presenter.view = view
    }
}
