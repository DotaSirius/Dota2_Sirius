import Foundation

protocol TeamsModuleInput: AnyObject {}

protocol TeamsModuleOutput: AnyObject {
    func teamsModule(_ module: TeamsModuleInput, didSelectTeam teamId: Int)
}

final class TeamsModulePresenter {
    weak var view: TeamsModuleViewInput? {
        didSet {
            loading()
        }
    }
    
    private let teamsService: TeamsService
    let output: TeamsModuleOutput

    private var teams = [TeamShortInfo]()
    private var requestToken: Cancellable?
    
    init(teamsService: TeamsService, output: TeamsModuleOutput) {
        self.teamsService = teamsService
        self.output = output
        print("init")
    }
    
    private func loading() {
        view?.updateState(.loading)

        let teamsRequestToken = teamsService.requestTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teamResult):
                print(teamResult)
                self.teams = teamResult.map { TeamShortInfo(from: $0) }
                self.view?.updateState(.success)
            case .failure:
                self.view?.updateState(.failure)
            }
        }
        
        requestToken = teamsRequestToken
    }
    
    deinit {
        requestToken?.cancel()
    }
}

// MARK: - TeamsModuleInput

extension TeamsModulePresenter: TeamsModuleInput {}

// MARK: - TeamsModuleViewOutput

extension TeamsModulePresenter: TeamsModuleViewOutput {
    var countOfRows: Int {
        teams.count
    }

    func getData(at indexPath: IndexPath) -> TeamShortInfo {
        teams[indexPath.row]
    }
    
    func selected(at indexPath: IndexPath) {
        print(indexPath)
        let team = teams[indexPath.row]
        output.teamsModule(self, didSelectTeam: team.teamId)
    }
}
