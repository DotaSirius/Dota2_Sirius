import Foundation

protocol MatchesModuleInput: AnyObject {}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectPlayer matchId: Int)
}

final class MatchesModulePresenter {
    weak var view: MatchesModuleViewInput?
    private let matchesService: MatchesService
    private var tournaments: [MatchCollectionPresenterData] = []
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
        for match in matches {
            let newMatch = TournamentViewState.MatchViewState(
                radiantTeam: match.radiantName ?? "Radiant team",
                radiant: match.radiantWin,
                direTeam: match.direName ?? "Dire team",
                id: match.matchId,
                radiantScore: match.radiantScore,
                direScore: match.direScore
            )
            
            if let index = tournaments.firstIndex(where: { $0.tournament.leagueName == match.leagueName } ) {
                tournaments[index].matches.append(newMatch)
            } else {
                tournaments.append(MatchCollectionPresenterData(
                    isOpen: false,
                    tournament: TournamentViewState(leagueName: match.leagueName),
                    matches: [newMatch])
                )
            }
        }
    }
}

// MARK: - MatchesModuleInput

extension MatchesModulePresenter: MatchesModuleInput {}

// MARK: - MatchesModuleViewOutput

extension MatchesModulePresenter: MatchesModuleViewOutput {
    func getSectionCount() -> Int {
        return tournaments.count
    }
    
    func getRowsInSection(section: Int) -> Int {
        if tournaments[section].isOpen {
            return tournaments[section].matches.count
        } else {
            return 0
        }
    }
    
    func getDataMatch(indexPath: IndexPath) -> TournamentViewState.MatchViewState {
        return tournaments[indexPath.section].matches[indexPath.row]
    }
    
    func getDataTournament(section: Int) -> TournamentViewState {
        return tournaments[section].tournament
    }
    
    func matchTapped(indexPath: IndexPath) {
        output.matchesModule(self, didSelectPlayer: tournaments[indexPath.section].matches[indexPath.row].id)
    }
    
    func tournamentTapped(section: Int) {
        tournaments[section].isOpen = !tournaments[section].isOpen
    }
}
