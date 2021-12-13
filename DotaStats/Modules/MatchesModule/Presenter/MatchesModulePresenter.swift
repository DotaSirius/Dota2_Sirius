import Foundation

protocol MatchesModuleInput: AnyObject {}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectPlayer match: Match)
}

final class MatchesModulePresenter {
    weak var view: MatchesModuleViewInput?
    private let matchesService: MatchesService
    private var matches: [MatchCollectionPresenterData] = []
    let output: MatchesModuleOutput
    
    required init(matchesService: MatchesService,
                  output: MatchesModuleOutput)
    {
        self.matchesService = matchesService
        self.output = output
        self.state = .none
    }
    
    private var state: MatchesModulePresenterState {
        didSet {
            oldValue.token?.cancel()
            switch state {
            case .result(let requestResult):
                switch requestResult {
                case .success(var matches):
                    matches.sort { $0.startTime < $1.startTime }
                    convertMatches(matches: matches)
                    view?.updateState(matchesModuleState: MatchesModuleViewState.success)
                case .failure(let error):
                    view?.updateState(matchesModuleState: MatchesModuleViewState.error(error.rawValue))
                }
            case .none, .loading:
                view?.updateState(matchesModuleState: MatchesModuleViewState.loading)
            }
        }
    }
    
    func setViewInput(view: MatchesModuleViewInput) {
        self.view = view
        updateView()
    }
    
    private func updateView() {
        let token = matchesService.requestProMatches() { [weak self] result in
            guard let self = self else { return }
            self.state = .result(result)
        }
        state = .loading(token)
    }
    
    private func convertMatches(matches: [Match]) {
        var tournaments = [String: MatchCollectionPresenterData.RowSection]()
        for match in matches {
            if tournaments[match.leagueName] != nil {
                tournaments[match.leagueName]!.row += 1
                let newCell = MatchCellType.matchViewState(TournamentViewState.MatchViewState(
                    radiantTeam: match.radiantName ?? "Radiant team",
                    radiant: match.radiantWin,
                    score: "\(match.radiantScore):\(match.direScore)",
                    direTeam: match.direName ?? "Dire team"
                ))
                
                let newMatch = MatchCollectionPresenterData(
                    rowSection: tournaments[match.leagueName]!,
                    isOpen: false,
                    matchCellType: newCell
                )
                self.matches.append(newMatch)
            } else {
                tournaments[match.leagueName] = MatchCollectionPresenterData.RowSection(
                    section: tournaments.count,
                    row: 0)
                let newCell = MatchCellType.tournamentViewState(TournamentViewState(
                    leagueName: match.leagueName))
                
                let newMatch = MatchCollectionPresenterData(
                    rowSection: tournaments[match.leagueName]!,
                    isOpen: false,
                    matchCellType: newCell
                )
                self.matches.append(newMatch)
            }
        }
    }
}

// MARK: - MatchesModuleInput

extension MatchesModulePresenter: MatchesModuleInput {}

// MARK: - MatchesModuleViewOutput

extension MatchesModulePresenter: MatchesModuleViewOutput {
    func getSectionCount() -> Int {
        // TODO:
        0
    }
    
    func getRowsInSection(section: Int) -> Int {
        // TODO:
        0
    }
    
    func getData(indexPath: IndexPath) -> MatchCellType {
        // TODO:
        MatchCellType.tournamentViewState(TournamentViewState(leagueName: ""))
    }
    
    func cellTapped(indexPath: IndexPath) {
        // TODO:
    }
}
