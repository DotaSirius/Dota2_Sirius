import Foundation

protocol MatchesModuleInput: AnyObject {
}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectPlayer match: Match)
}

final class MatchesModulePresenter {
    weak var view: MatchesModuleViewInput?
    private let networkService: NetworkService
    let output: MatchesModuleOutput
    
    required init(networkService: NetworkService,
                  output: MatchesModuleOutput) {
        self.networkService = networkService
        self.output = output
    }
}

// MARK: - MatchesModuleInput

extension MatchesModulePresenter: MatchesModuleInput {
}

// MARK: - MatchesModuleViewOutput

extension MatchesModulePresenter: MatchesModuleViewOutput{
    func getSectionCount() -> Int {
        // TODO
        0
    }
    
    func getRowsInSection(section: Int) -> Int {
        // TODO
        0
    }
    
    func getData(indexPath: IndexPath) -> MatchCellType {
        // TODO
        MatchCellType.tournamentViewState(TournamentViewState(leagueName: ""))
    }
    
    func cellTapped(indexPath: IndexPath) {
        // TODO
    }
}
