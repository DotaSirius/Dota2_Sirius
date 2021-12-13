import Foundation

protocol SearchPlayerModuleInput: AnyObject {}

protocol SearchPlayerModuleOutput: AnyObject {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: Players)
}

final class SearchPlayerModulePresenter {
    let output: SearchPlayerModuleOutput
    
    weak var view: SearchPlayerModuleViewInput? {
        didSet {
            view?.updateState(viewState)
        }
    }
    
    private let playerNetworkService: PlayerSearchNetworkService
    private let imageNetworkService: ImageNetworkService
    
    private var players = [Players]()
    private var imageTokens = [IndexPath: Cancellable]()
    
    private var viewState: SearchPlayerModuleViewState {
        viewState(from: state)
    }
    
    private func viewState(from state: SearchPlayerModulePresenterState) -> SearchPlayerModuleViewState {
        switch state {
        case .none:
            return .startScreen
        case .loading:
            return .loading
        case .result(let result):
            switch result {
            case .success:
                return players.isEmpty ? .empty : .success
            case .failure:
                return .failure
            }
        }
    }
    
    private var state: SearchPlayerModulePresenterState {
        didSet {
            oldValue.token?.cancel()
            switch state {
            case .result(let requestResult):
                switch requestResult {
                case .success(let players):
                    self.players = players
                case .failure(_):
                    break
                }
            case .none, .loading:
                break
            }
            
            view?.updateState(viewState)
        }
    }
    
    init(output: SearchPlayerModuleOutput, playerNetworkService: PlayerSearchNetworkService, imageNetworkService: ImageNetworkService) {
        self.output = output
        self.playerNetworkService = playerNetworkService
        self.imageNetworkService = imageNetworkService
        state = .none
    }
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {
    var count: Int {
        players.count
    }
    
    func getData(indexPath: IndexPath) -> Players {
        let player = players[indexPath.row]
        if let urlString = player.profile?.avatarfull, let url = URL(string: urlString)  {
            imageTokens[indexPath]?.cancel()
            let token = imageNetworkService.loadImageFromURL(url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.view?.reloadCellForIndexPath(indexPath, withImage: image)
                    self.imageTokens[indexPath] = nil
                case .failure(_):
                    break
                }
            }
            imageTokens[indexPath] = token
        }
        
        return player
    }
    
    func search(_ name: String) {
        if !name.isEmpty {
            let token = playerNetworkService.playersByName(name) { [weak self] result in
                guard let self = self else { return }
                self.state = .result(result)
            }
            state = .loading(token)
        } else {
            state = .none
        }
    }
    
    func playerSelected(_ player: Players) {
        output.searchModule(self, didSelectPlayer: player)
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {}
