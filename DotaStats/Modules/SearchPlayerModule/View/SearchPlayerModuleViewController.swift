import UIKit

protocol SearchPlayerModuleViewInput: AnyObject {
    func updateState(_ state: SearchPlayerModuleViewState)
}

protocol SearchPlayerModuleViewOutput: AnyObject {
    var count: Int { get }
    // TODO: func getData(indexPath: IndexPath) -> Players
    func search(_ name: String)
}

// MARK: Экран с поиском игроков!

final class SearchPlayerModuleViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(loadingCircle)
        view.addSubview(errorView)

        errorView.isUserInteractionEnabled = true
        let tapActionHideError = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        errorView.addGestureRecognizer(tapActionHideError)

        setUpErrorViewConstraints()
        setUpSearchBarConstraints()
        setUpLoadingCircleConstraints()
        setUpTableViewConstraints()
        updateState(.failure)
    }

    // MARK: Spinner

    private lazy var loadingCircle: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = ColorPalette.accent
        return view
    }()

    // MARK: ErrorView

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.alpha = 0
        return view
    }()

    // MARK: UITableView

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchPlayerTableViewCell.self, forCellReuseIdentifier: SearchPlayerTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorPalette.mainBackground
        tableView.separatorColor = ColorPalette.separator
        tableView.rowHeight = 55
        return tableView
    }()

    // MARK: UISearchBar

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = ColorPalette.mainBackground
        searchBar.searchTextField.textColor = ColorPalette.mainText
        searchBar.searchTextField.backgroundColor = ColorPalette.separator
        searchBar.tintColor = ColorPalette.mainText
        searchBar.searchTextField.leftView?.tintColor = ColorPalette.mainText
        return searchBar
    }()

    // MARK: SearchBar Constraints

    private func setUpSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: errorView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: TableView Constraints

    private func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: LoadingCircle Constraints

    private func setUpLoadingCircleConstraints() {
        loadingCircle.color = ColorPalette.text
        loadingCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: ErrorView Constraints

    private var errorConstraint: NSLayoutConstraint?

    private func setUpErrorViewConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        let errorConstraint = errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorConstraint,
            errorView.heightAnchor.constraint(equalToConstant: 90)
        ])
        self.errorConstraint = errorConstraint
    }

    // MARK: Show/hide errors function

    func showError() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut]) {
            self.errorConstraint?.constant = 35
            self.errorView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    func hideError() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseOut]) {
            self.errorConstraint?.constant = 0
            self.errorView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }

    @objc func handleTap(_: UITapGestureRecognizer) {
        hideError()
        print("tapped")
    }
}

// MARK: extension for TableView

extension SearchPlayerModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlayerTableViewCell.reuseIdentifier, for: indexPath) as? SearchPlayerTableViewCell else {
            return .init()
        }

        cell.configurePlayer(UIImage(named: "players")!, "Alex", "В сети")
        cell.backgroundColor = indexPath.row % 2 == 0 ? ColorPalette.mainBackground : ColorPalette.alternatеBackground
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

// MARK: extension for SearchBar

extension SearchPlayerModuleViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
}

// MARK: - SearchModuleViewInput

extension SearchPlayerModuleViewController: SearchPlayerModuleViewInput {
    func updateState(_ state: SearchPlayerModuleViewState) {
        switch state {
        case .startScreen:
            tableView.isHidden = true
        // TODO: картинка начал экрана
        case .empty:
            tableView.isHidden = true
        // TODO: картинка ничего не нашёл
        case .loading:
            hideError()
            tableView.isHidden = true
            loadingCircle.startAnimating()
        // TODO: добавить кастомную загрузку
        case .success:
            hideError()
            loadingCircle.stopAnimating()
            tableView.reloadData()
            tableView.isHidden = false
        case .failure:
            showError()
            // TODO: картинка ошибки
        }
    }
}
