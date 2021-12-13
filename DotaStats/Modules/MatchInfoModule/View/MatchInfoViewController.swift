import UIKit

protocol MatchInfoModuleViewInput: AnyObject {
    func updateState(to state: MatchesInfoModuleState)
    // TODO: update staqte обновляет у vc стейт (.loading/ .error)
}

final class MatchInfoViewController: UIViewController {
    private let colorPalette = ColorPalette()
    var output: MatchInfoModuleViewOutput?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AdditionalMatchInfoTableViewCell.self, forCellReuseIdentifier: AdditionalMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MainMatchInfoTableViewCell.self, forCellReuseIdentifier: MainMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MatchPlayerCell.self, forCellReuseIdentifier: MatchPlayerCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorPalette.mainBackground
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
        view.backgroundColor = ColorPalette.mainBackground
        view.addSubview(tableView)
        setUpConstraints()
    }

    func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource extension

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
            let data = output?.getCellData(indexPath: indexPath.row),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: data.type.reuseIdentificator,
                for: indexPath) as? (UITableViewCell & DetailedMatchInfoCellConfigurable)
        else {
            // TODO: - Error handling
            return UITableViewCell()
        }
        cell.configure(with: data)
        return cell
    }
}

// MARK: - MatchInfoModuleViewInput extension

extension MatchInfoViewController: MatchInfoModuleViewInput {
    func updateState(to state: MatchesInfoModuleState) {
        // TODO: - Write updateState method
    }
}
