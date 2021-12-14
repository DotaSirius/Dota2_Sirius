import Foundation

protocol MatchesModuleInput: AnyObject {}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectMatch matchId: Int)
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
            case .success(let matches):
                convert(matches)
                view?.update(state: .success)
            case .error(let error):
                view?.update(state: .error(error.localizedDescription))
            case .loading:
                view?.update(state: .loading)
            case .none:
                break
            }
        }
    }
    
    private func updateView() {
        let token = matchesService.requestProMatches { [weak self] result in
            switch result {
            case .success(let matches):
                self?.state = .success(matches)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
        state = .loading(token)
    }
    
    private func convert(_ matches: [Match]) {
        for match in matches.sorted() {
            let newMatch = convertTo(match)
            
            if let index = tournaments.firstIndex(where: { $0.tournament.leagueName == match.leagueName }) {
                tournaments[index].matches.append(newMatch)
            } else {
                let matchData = MatchCollectionPresenterData(
                    isOpen: false,
                    tournament: TournamentViewState(leagueName: match.leagueName),
                    matches: [newMatch]
                )
                tournaments.append(matchData)
            }
        }
    }
    
    private func convertTo(_ match: Match) -> TournamentViewState.MatchViewState {
        TournamentViewState.MatchViewState(
            radiantTeam: match.radiantName ?? NSLocalizedString("Radiant team", comment: ""),
            radiant: match.radiantWin,
            direTeam: match.direName ?? NSLocalizedString("Dire team", comment: ""),
            id: match.matchId,
            radiantScore: match.radiantScore,
            direScore: match.direScore
        )
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
        output.matchesModule(self, didSelectMatch: tournaments[indexPath.section].matches[indexPath.row].id)
    }
    
    func tournamentTapped(section: Int) {
        tournaments[section].isOpen = !tournaments[section].isOpen
        view?.updateSection(section: section)
    }
}
