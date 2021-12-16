import Foundation

protocol TeamsModuleInput: AnyObject {}

protocol TeamsModuleOutput: AnyObject {
    func teamsModule(_ module: TeamsModuleInput, didSelectTeam teamId: Int)
}

final class TeamsModulePresenter {
    weak var view: TeamsModuleViewInput?
    private let networkService: NetworkService
    let output: TeamsModuleOutput
    
    private var teams = [TeamShortInfo]()
    
    required init(networkService: NetworkService,
                  output: TeamsModuleOutput){
        self.networkService = networkService
        self.output = output
    }
}

// MARK: - TeamsModuleInput

extension TeamsModulePresenter: TeamsModuleInput {}

// MARK: - TeamsModuleViewOutput

extension TeamsModulePresenter: TeamsModuleViewOutput {
    func selected(at indexPath: IndexPath) {
        let team = teams[indexPath.row]
        output.teamsModule(self, didSelectTeam: team.teamId)
    }
}
