import Foundation

protocol SearchPlayerModuleInput: AnyObject {}

protocol SearchPlayerModuleOutput: AnyObject {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: Players)
}

final class SearchPlayerModulePresenter {
    let output: SearchPlayerModuleOutput
    
    weak var view: SearchPlayerModuleViewInput?
    
    private let networkService: PlayerSearchNetworkService
    
    private var players = [Players]()
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
            case .success(let players):
                self.players = players
                return .success
            case .failure(let error):
                print(error)
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
                case .failure(let error):
                    print(error)
                }
            default:
                break
            }
            
            view?.updateState(viewState)
        }
    }
    
    init(output: SearchPlayerModuleOutput, networkService: PlayerSearchNetworkService) {
        self.output = output
        self.networkService = networkService
        state = .none
    }
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {
    var count: Int {
        players.count
    }
    
    func getData(indexPath: IndexPath) -> Players {
        players[indexPath.row]
    }
    
    func search(_ name: String) {
        if !name.isEmpty {
            let token = networkService.playersByName(name) { [weak self] result in
                guard let self = self else { return }
                self.state = .result(result)
            }
            state = .loading(token)
            
        } else {
            state = .none
        }
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {}
//
//    switch state {
//    case .loading(let token):
//        if oldValue == SearchPlayerModulePresenterState.loading {
//
//        }
//    case .result(let resultData):
//        switch resultData {
//        case .success(let players):
//            self.players = players
//            viewState = .success
//        case .failure(let error):
//            print(error)
//            viewState = .failure
//        }
//    }
// }
