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
                score: "\(match.radiantScore):\(match.direScore)",
                direTeam: match.direName ?? "Dire team"
            )
            
            if let index = tournaments.firstIndex(where: { $0.tournament.leagueName == match.leagueName } ) {
                tournaments[index].matches.append(newMatch)
            } else {
                tournaments.append(MatchCollectionPresenterData(
                    isOpen: false,
                    tournamentNumber: tournaments.count,
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
        if let index = tournaments.firstIndex(where: { $0.tournamentNumber == section } ) {
            if tournaments[index].isOpen {
                return tournaments[index].matches.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func getDataMatch(indexPath: IndexPath) -> TournamentViewState.MatchViewState {
        if let index = tournaments.firstIndex(where: { $0.tournamentNumber == indexPath.section } ) {
            if (tournaments[index].isOpen) {
                return tournaments[index].matches[indexPath.row]
            }
        }
        return TournamentViewState.MatchViewState(
            radiantTeam: "",
            radiant: false,
            score: "",
            direTeam: "")
    }
    
    func getDataTournament(section: Int) -> TournamentViewState {
        if let index = tournaments.firstIndex(where: { $0.tournamentNumber == section } ) {
            return tournaments[index].tournament
        }
        return TournamentViewState(leagueName: "")
    }
    
    func cellTapped(indexPath: IndexPath) {
        /*for (index, tournament) in tournaments.enumerated() {
            if (tournament.rowSection.section == indexPath.section && match.rowSection.row == indexPath.row) {
                switch match.matchCellType {
                    case .tournamentViewState(_):
                        view?.updateSection(section: indexPath.section)
                        matches[index].isOpen = !matches[index].isOpen
                    case .matchViewState(_):
                        output.matchesModule(self, didSelectPlayer: match.id)
                }
            }
        }*/
    }
}
