import UIKit

protocol PlayerInfoModuleViewInput: AnyObject {
    func update(state: PlayerInfoModuleViewState)
}

protocol PlayerInfoModuleViewOutput: AnyObject {
    // func getMainData() -> PlayerMainInfoView
    func getCellData(forSection: Int) -> PlayerTableViewCellData
    func getRowsInSection(section: Int) -> Int
}

final class PlayerInfoModuleViewController: UIViewController {
    // MARK: - Properties

    private var output: PlayerInfoModuleViewOutput?
    private var data: PlayerTableViewCellData?
    private var spiner = UIActivityIndicatorView(style: .large)

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlayerMainInfoCell.self,
                           forCellReuseIdentifier: PlayerMainInfoCell.reuseIdentifier)
        tableView.register(PlayerWLCell.self,
                           forCellReuseIdentifier: PlayerWLCell.reuseIdentifier)
        tableView.register(PlayerMatchCell.self,
                           forCellReuseIdentifier: PlayerWLCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorPalette.mainBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Init

    init(output: PlayerInfoModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PlayerInfoModuleViewController: PlayerInfoModuleViewInput {
    func update(state: PlayerInfoModuleViewState) {
        switch state {
        case .loading:
            spiner.color = ColorPalette.accent
            view.addSubview(spiner)
            spiner.center = view.center
            spiner.startAnimating()
        case .error:
            spiner.removeFromSuperview()
        case .success:
            setupTableView()
            spiner.removeFromSuperview()
        }
    }
}

extension PlayerInfoModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let data = output?.getCellData(forSection: indexPath.section),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: data.reuseIdentificator,
                for: indexPath) as? (UITableViewCell & PlayerInfoCellConfigurable)
        else {
            // TODO: - Error handling
            return UITableViewCell()
        }
        cell.backgroundColor = ColorPalette.mainBackground
        cell.configure(with: data)
        return cell
    }
}
