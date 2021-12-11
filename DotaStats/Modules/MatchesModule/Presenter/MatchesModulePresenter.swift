import Foundation

protocol MatchesModuleInput: AnyObject {
}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectPlayer match: Match)
}

final class MatchesModulePresenter {
    weak var view: MatchesModuleViewInput?
    private let networkService: NetworkService
    private var matches: [MatchCollectionPresenterData] = []
    let output: MatchesModuleOutput
    
    required init(networkService: NetworkService,
                  output: MatchesModuleOutput) {
        self.networkService = networkService
        self.output = output
    }
    
    func setViewInput(view: MatchesModuleViewInput) {
        self.view = view
        self.updateView()
    }
    
    private func updateView() {
        view?.updateState(matchesModuleState: MatchesModuleState.loading)
        var matches = networkService.proMatches()
        matches.sort { $0.startTime < $1.startTime }
        /* Add check after I have protocol from network
        if (matches.count == 0) {
            view?.updateState(matchesModuleState: MatchesModuleState.error("no data"))
        }*/
        convertMatches(matches: matches)
        view?.updateState(matchesModuleState: MatchesModuleState.success)
    }
    
    private func convertMatches(matches: [Match]) {
        var tournaments = [String: [Int]]()
        for match in matches {
            if tournaments[match.leagueName] != nil {
                tournaments[match.leagueName]![1] += 1
            } else {
                tournaments[match.leagueName] = [tournaments.count, 1]
            }
        }
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
