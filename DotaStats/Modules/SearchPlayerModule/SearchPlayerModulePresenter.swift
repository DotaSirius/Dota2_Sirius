import Foundation

protocol SearchPlayerModuleInput: AnyObject {}

protocol SearchPlayerModuleOutput: AnyObject {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: PlayerInfoFromSearch)
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

    private var imageRequestTokens = [String: Cancellable]()
    private var players = [PlayerInfoFromSearch]() {
        didSet {
            cancelAllImageRequestTokens()
        }
    }

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

    init(
        output: SearchPlayerModuleOutput,
        playerSearchService: PlayerSearchService,
        imageNetworkService: ImageNetworkService
    ) {
        self.output = output
        self.playerSearchService = playerSearchService
        self.imageNetworkService = imageNetworkService
        state = .none
    }

    private func cancelAllImageRequestTokens() {
        imageRequestTokens.forEach { _, request in
            request.cancel()
        }

        imageRequestTokens.removeAll()
    }

    private func loadAvatar(player: PlayerInfoFromSearch, completion: (() -> Void)? = nil) {
        guard let urlString = player.avatarFull, let url = URL(string: urlString) else { return }
        let imageRequestToken = imageNetworkService.loadImageFromURL(url) { [weak self] result in
            switch result {
            case .success(let avatar):
                player.avatar = avatar
                completion?()
            case .failure:
                break
            }
            self?.imageRequestTokens[urlString] = nil
        }

        imageRequestTokens[urlString] = imageRequestToken
    }

    deinit {
        cancelAllImageRequestTokens()
    }
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {

    var countOfRows: Int {
        players.count
    }

    func getData(at indexPath: IndexPath) -> PlayerInfoFromSearch {
        let player = players[indexPath.row]
        if player.avatar == nil {
            loadAvatar(player: player) { [weak self] in
                self?.view?.reload(at: indexPath)
            }
        }

        return player
    }

    func prefetchData(at indexPath: IndexPath) {
        let player = players[indexPath.row]
        guard player.avatar == nil else { return }
        loadAvatar(player: player)
    }

    func search(_ name: String) {
        if !name.isEmpty {
            let searchRequestToken = playerSearchService.playersByName(name) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let search):
                    let searchPlayers = search.map { PlayerInfoFromSearch(from: $0) }
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

    func playerTapped(at indexPath: IndexPath) {
        output.searchModule(self, didSelectPlayer: players[indexPath.row])
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {}
