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
    private var imageLoading = [IndexPath: ImageLoading]()
    
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
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {
    var count: Int {
        players.count
    }
    
    func getData(indexPath: IndexPath) -> PlayerSearch {
        players[indexPath.row].avatar = imageLoading[indexPath]?.avatar
        if let urlString = players[indexPath.row].avatarFull, let url = URL(string: urlString)  {
            let token = imageNetworkService.loadImageFromURL(url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imageLoading[indexPath]?.avatar = image
                    self.view?.reloadCellForIndexPath(indexPath, withImage: image)
                case .failure(_):
                    break
                }
            }
            imageLoading[indexPath]?.token = token
        }
        
        return players[indexPath.row]
    }
    
    func search(_ name: String) {
        if !name.isEmpty {
            let token = playerSearchService.playersByName(name) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let search):
                    let searchPlayers = search.map { PlayerSearch(from: $0) }
                    self.state = .success(searchPlayers)
                case .failure(let error):
                    self.state = .failure(error)
                }
            }
            state = .loading(token)
        } else {
            state = .none
        }
    }
    
    func playerSelected(_ player: PlayerSearch) {
        output.searchModule(self, didSelectPlayer: player)
    }
    
    func cellEndDisplayingForIndexPath(_ indexPath: IndexPath) {
        imageLoading[indexPath]?.token?.cancel()
        imageLoading[indexPath] = nil
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {}
