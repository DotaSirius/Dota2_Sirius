import Foundation

protocol MatchesModuleInput: AnyObject {}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectPlayer matchId: Int)
}

final class MatchesModulePresenter {
    weak var view: MatchesModuleViewInput? {
        didSet {
            updateView()
        }
    }
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
            switch state {
            case .result(let requestResult):
                switch requestResult {
                case .success(var matches):
                    matches.sort { $0 < $1 }
                    convert(matches)
                    view?.update(state: .success)
                case .failure(let error):
                    view?.update(state: .error(error.localizedDescription))
                }
            case .loading:
                view?.update(state: .loading)
            case .none:
                break
            }
        }
    }
    
    private func updateView() {
        let token = matchesService.requestProMatches { [weak self] result in
            self?.state = .result(result)
        }
        state = .loading(token)
    }
    
    private func convert(_ matches: [Match]) {
        for match in matches {
            let newMatch = TournamentViewState.MatchViewState(
                radiantTeam: match.radiantName ?? NSLocalizedString("Radiant team", comment: ""),
                radiant: match.radiantWin,
                direTeam: match.direName ?? NSLocalizedString("Dire team", comment: ""),
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
