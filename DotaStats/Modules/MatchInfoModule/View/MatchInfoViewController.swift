import UIKit

protocol MatchInfoModuleViewInput: AnyObject {
    func updateState(to state: MatchesInfoModuleState)
}

final class MatchInfoViewController: UIViewController {
    var spiner = UIActivityIndicatorView(style: .large)

    var output: MatchInfoModuleViewOutput?
    var data: MatchTableViewCellData?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AdditionalMatchInfoTableViewCell.self,
                           forCellReuseIdentifier: AdditionalMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MainMatchInfoTableViewCell.self,
                           forCellReuseIdentifier: MainMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MatchPlayerCell.self,
                           forCellReuseIdentifier: MatchPlayerCell.reuseIdentifier)
        tableView.register(TeamMatchInfoTableViewCell.self,
                           forCellReuseIdentifier: TeamMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(PlayersTableHeaderCell.self,
                           forCellReuseIdentifier: PlayersTableHeaderCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorPalette.mainBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    init(output: MatchInfoModuleViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateState(to: .success)
    }

    func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MatchInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let output = output
        else {
            // TODO: - Error handling
            return 0
        }
        return output.getRowsCountInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let data = output?.getCellData(for: indexPath.row),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: data.type.reuseIdentificator,
                for: indexPath) as? (UITableViewCell & DetailedMatchInfoCellConfigurable)
        else {
            // TODO: - Error handling
            return UITableViewCell()
        }
        let isEven = indexPath.row % 2 == 0
        let matchPlayersCellIndexes = indexPath.row > 3
        cell.backgroundColor = (isEven && matchPlayersCellIndexes) ? ColorPalette.alternativeBackground : ColorPalette.mainBackground
        cell.configure(with: data)
        return cell
    }
}

extension MatchInfoViewController: MatchInfoModuleViewInput {
    func updateState(to state: MatchesInfoModuleState) {
            switch state {
            case .loading:
                spiner.color = ColorPalette.accent
                view.addSubview(spiner)
                spiner.center = view.center
                spiner.startAnimating()
            case .error:
                spiner.removeFromSuperview()
                // TO DO: Errors
            case .success:
                view.addSubview(tableView)
                setUpConstraints()
            } // TODO: - Write updateState method
    }
}
