import Foundation

protocol SearchPlayerModuleInput: AnyObject {}

protocol SearchPlayerModuleOutput: AnyObject {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: PlayerSearch)
}

final class SearchPlayerModulePresenter {
    let output: SearchPlayerModuleOutput
    
    weak var view: SearchPlayerModuleViewInput? {
        didSet {
            view?.updateState(viewState)
        }
    }
    
    private let playerSearchService: PlayerSearchService
    private let imageNetworkService: ImageNetworkService
    
    private var players = [PlayerSearch]()
    private var imageRequestTokens = [IndexPath: Cancellable]()
    
    private var viewState: SearchPlayerModuleViewState {
        viewState(from: state)
    }
    
    private func viewState(from state: SearchPlayerModulePresenterState) -> SearchPlayerModuleViewState {
        switch state {
        case .none:
            return .startScreen
        case .loading:
            return .loading
        case .success(let players):
            return players.isEmpty ? .empty : .success
        case .failure:
            return .failure
        }
    }
    
    private var state: SearchPlayerModulePresenterState {
        didSet {
            oldValue.token?.cancel()
            switch state {
            case .success(let result):
                players = result
            case .none, .loading, .failure:
                break
            }
            
            view?.updateState(viewState)
        }
    }
    
    init(output: SearchPlayerModuleOutput, playerSearchService: PlayerSearchService, imageNetworkService: ImageNetworkService) {
        self.output = output
        self.playerSearchService = playerSearchService
        self.imageNetworkService = imageNetworkService
        state = .none
    }
    
    deinit {
        imageRequestTokens.forEach { _, request in
            request.cancel()
        }
    }
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {
    var count: Int {
        players.count
    }
    
    func getData(indexPath: IndexPath) -> PlayerSearch {
        if let urlString = players[indexPath.row].avatarFull,
            let url = URL(string: urlString) {
            let imageRequestToken = imageNetworkService.loadImageFromURL(url) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.players[indexPath.row].avatar = image
                    self?.imageRequestTokens[indexPath] = nil
                    self?.view?.reload(at: indexPath)
                case .failure(_):
                    break
                }
            }
            imageRequestTokens[indexPath] = imageRequestToken
        }
        
        return players[indexPath.row]
    }
    
    func search(_ name: String) {
        if !name.isEmpty {
            let searchRequestToken = playerSearchService.playersByName(name) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let search):
                    let searchPlayers = search.map { PlayerSearch(from: $0) }
                    self.state = .success(searchPlayers)
                case .failure(let error):
                    self.state = .failure(error)
                }
            }
            state = .loading(searchRequestToken)
        } else {
            state = .none
        }
    }
    
    func playerSelected(_ player: PlayerSearch) {
        output.searchModule(self, didSelectPlayer: player)
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {}
