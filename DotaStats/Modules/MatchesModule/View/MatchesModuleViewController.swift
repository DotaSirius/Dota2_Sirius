import UIKit

// MARK: - Protocols

protocol MatchesModuleViewInput: AnyObject {
    func update(state: MatchesModuleViewState)
//    func updateSection(section: Int)
    func insertRows(_ rows: [IndexPath])
    func deleteRows(_ rows: [IndexPath])
}

protocol MatchesModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsInSection(section: Int) -> Int
    func getDataMatch(indexPath: IndexPath) -> TournamentViewState.Match
    func getDataTournament(section: Int) -> TournamentViewState
    func matchTapped(indexPath: IndexPath)
    func tournamentTapped(section: Int)
}

final class MatchesModuleViewController: UIViewController {
    // MARK: - Properties

    private var output: MatchesModuleViewOutput?
    var spiner = UIActivityIndicatorView(style: .large)
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ListMatchesCell.self, forCellReuseIdentifier: ListMatchesCell.reuseIdentifier)
        table.register(ListTournamentsCell.self, forHeaderFooterViewReuseIdentifier: ListTournamentsCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = ColorPalette.mainBackground
        table.separatorColor = ColorPalette.separator
        table.separatorInset = .zero
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = ColorPalette.alternativeBackground
        label.text = "MATCHES"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = ColorPalette.mainText
        return label
    }()

    // MARK: - Init
    init(output: MatchesModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Set up UILabel "MATCHES"

    private func setUpLabel() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.bottomAnchor.constraint(equalTo: tableView.topAnchor),
        ])
    }

    // MARK: - Set up UITableView

    private func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - MatchesModuleViewInput

extension MatchesModuleViewController: MatchesModuleViewInput {
    func update(state: MatchesModuleViewState) {
        switch state {
        case .loading:
            spiner.color = ColorPalette.accent
            view.addSubview(spiner)
            spiner.center = view.center
            spiner.startAnimating()
        case .error:
            spiner.removeFromSuperview()
        case .success:
            spiner.removeFromSuperview()
            setUpTableView()
            setUpLabel()
        }
    }

    func insertRows(_ rows: [IndexPath]) {
        tableView.insertRows(at: rows, with: .automatic)
    }

    func deleteRows(_ rows: [IndexPath]) {
        tableView.deleteRows(at: rows, with: .automatic)
    }
}

// MARK: - UITableViewDataSource

extension MatchesModuleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output?.getSectionCount() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.2
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = output?.getDataMatch(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMatchesCell.reuseIdentifier, for: indexPath) as? ListMatchesCell else { return UITableViewCell() }
        cell.setup()
        cell.firstTeam.text = data?.radiantTeam.trimmingCharacters(in: .whitespaces)
        cell.score.text = data?.score
        cell.secondTeam.text = data?.direTeam.trimmingCharacters(in: .whitespaces)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MatchesModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.matchTapped(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - ListTournamentsCellDelegate

extension MatchesModuleViewController: ListTournamentsCellDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = output?.getDataTournament(section: section)
        let count = output?.getRowsInSection(section: section) ?? 0
        let header = ListTournamentsCell()
        header.setup(withTitle: data?.leagueName ?? "ChampionShip", section: section, delegate: self)
        if count != 0{
            header.setCollapsed(false)
        } else {
            header.setCollapsed(true)
        }
        return header
    }

    func toggleSection(header: ListTournamentsCell, section: Int) {
        output?.tournamentTapped(section: section)
    
        
    }
}
