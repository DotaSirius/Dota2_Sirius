import Foundation

// После переписанного NetworkService будет так +/-
func costilPlayers(completion: @escaping (Result<[Player], HTTPError>) -> Void) {
}

func costilPlayersByName(_ name: String, completion: @escaping (Result<[Players], HTTPError>) -> Void) {
}

protocol SearchPlayerModuleInput: AnyObject {
}

protocol SearchPlayerModuleOutput: AnyObject {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: Players)
}

final class SearchPlayerModulePresenter {
    let output: SearchPlayerModuleOutput
    
    weak var view: SearchPlayerModuleViewInput?
    
    private let networkService: PlayerSearchNetworkService
    
    private var data = [Players]()
    private var state: SearchPlayerModuleViewState {
        didSet {
            view?.updateState(state)
        }
    }
    
    init(output: SearchPlayerModuleOutput, networkService: PlayerSearchNetworkService) {
        self.output = output
        self.networkService = networkService
    }
    
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {
    var count: Int {
        data.count
    }
    
    func getData(indexPath: IndexPath) -> Players {
        data[indexPath.row]
    }

    func search(_ name: String) {
        if !name.isEmpty {
            state = .loading
            view?.updateState(state)
            networkService.playersByName(name) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.state = .success(data)
                case .failure(let error):
                    self.state = .failure(error)
                }
            }
        }
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {
}
//
//state = .loading
//networkService.playersByName(<#T##name: String##String#>, completion: <#T##(Result<[Players], HTTPError>) -> Void#>) { [weak self] result in
//    guard let self = self, let view = self.view else { return }
//    switch result {
//    case .success(let data):
//        self.data = data
//        view.updateState(.success(data))
//    case .failure(let error):
//        view.updateState(.failure(error))
//    }
//}
