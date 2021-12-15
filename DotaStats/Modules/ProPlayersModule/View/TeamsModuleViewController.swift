import UIKit

protocol TeamsModuleViewInput: AnyObject {
    func updateState(_ state: TeamModuleViewState)
}

protocol TeamsModuleViewOutput: AnyObject {
    func playerSelected(_ player: Player)
}

final class TeamsModuleViewController: UIViewController {
//    private var output: ProPlayersModuleViewOutput?
//
//    init(output: ProPlayersModuleViewOutput) {
//        self.output = output
//        super.init(nibName: nil, bundle: nil)
//
//    }
    private lazy var tableView = UITableView()

    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.register(TeamsCell.self, forCellReuseIdentifier: TeamsCell.identifier)
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }
}

// MARK: - PlayersModuleViewInput

extension TeamsModuleViewController: TeamsModuleViewInput {
    func updateState(_ state: TeamModuleViewState) {
        //
    }
}

extension TeamsModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamsCell.identifier) as? TeamsCell else {
            return .init()
        }
        cell.configure(with: "https://steamusercontent-a.akamaihd.net/ugc/1773822957617535601/F40F2155B92321415E972B787C5B1B0FFF06155A/", numOfTeam: indexPath.row)
        return cell
    }

}


