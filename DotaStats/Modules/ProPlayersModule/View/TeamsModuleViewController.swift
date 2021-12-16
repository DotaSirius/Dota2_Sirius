import UIKit

protocol TeamsModuleViewInput: AnyObject {
    func updateState(_ state: TeamsModuleViewState)
}

protocol TeamsModuleViewOutput: AnyObject {
    func selected(at indexPath: IndexPath)
}

final class TeamsModuleViewController: UIViewController {
//    private var output: ProPlayersModuleViewOutput?
//
//    init(output: ProPlayersModuleViewOutput) {
//        self.output = output
//        super.init(nibName: nil, bundle: nil)
//
//    }

    private enum Constant {
        static let headerHeight: CGFloat = 40
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TeamsCell.self, forCellReuseIdentifier: TeamsCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorPalette.mainBackground
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }

        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = ColorPalette.mainBackground
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

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - PlayersModuleViewInput

extension TeamsModuleViewController: TeamsModuleViewInput {
    func updateState(_ state: TeamsModuleViewState) {
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

extension TeamsModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? TeamsHeaderView else { return }
        view.contentView.backgroundColor = ColorPalette.mainBackground
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TeamsHeaderView()
        header.setup(delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constant.headerHeight
    }
}

extension TeamsModuleViewController: TeamsHeaderViewDelegate {
    func nameTapped() {
        //
    }
    
    func ratingTapped() {
        //
    }
    
    func winrateTapped() {
        //
    }
}
