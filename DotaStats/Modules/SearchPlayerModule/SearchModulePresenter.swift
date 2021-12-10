import Foundation

// После переписанного NetworkService будет так +/-
func costilPlayers(completion: @escaping (Result<[Player], SearchPlayerModuleError>) -> Void) {
}

func costilPlayersByName(_ name: String, completion: @escaping (Result<[Player], SearchPlayerModuleError>) -> Void) {
}

protocol SearchPlayerModuleInput: AnyObject {
}

protocol SearchPlayerModuleOutput: AnyObject {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: Player)
}

final class SearchPlayerModulePresenter {
    weak var view: SearchPlayerModuleViewInput?
    private let networkService: NetworkService
    let output: SearchPlayerModuleOutput
    private var data = [Player]()
    private var proPlayers = [Player]()
    
    init(output: SearchPlayerModuleOutput, networkService: NetworkService) {
        self.output = output
        self.networkService = networkService
        view?.updateState(.loading)
        costilPlayers { [weak self] result in
            guard let self = self, let view = self.view else { return }
            switch result {
            case .success(let data):
                self.proPlayers = data
                self.data = data
                view.updateState(.success(data))
            case .failure(let error):
                view.updateState(.failure(error))
            }
        }
    }
}

// MARK: - SearchModuleViewOutput

extension SearchPlayerModulePresenter: SearchPlayerModuleViewOutput {
    var count: Int {
        data.count
    }
    
    func getData(indexPath: IndexPath) -> Player {
        data[indexPath.row]
    }
    
    func playerSelected(_ player: Player) {
        output.searchModule(self, didSelectPlayer: player)
    }
    
    func search(_ name: String) {
        if name.isEmpty {
            data = proPlayers
            view?.updateState(.success(proPlayers))
        } else  {
            costilPlayersByName(name) { [weak self] result in
                guard let self = self, let view = self.view else { return }
                switch result {
                case .success(let data):
                    self.data = data
                    view.updateState(.success(data))
                case .failure(let error):
                    view.updateState(.failure(error))
                }
            }
        }
    }
}

// MARK: - SearchPlayerModuleInput

extension SearchPlayerModulePresenter: SearchPlayerModuleInput {
}
