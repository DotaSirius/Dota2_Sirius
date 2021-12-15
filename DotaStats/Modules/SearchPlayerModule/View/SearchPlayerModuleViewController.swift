import UIKit

protocol SearchPlayerModuleViewInput: AnyObject {
    func updateState(_ state: SearchPlayerModuleViewState)
    func reload(at indexPath: IndexPath)
}

protocol SearchPlayerModuleViewOutput: AnyObject {
    var countOfRows: Int { get }
    func getData(at indexPath: IndexPath) -> PlayerInfoFromSearch
    func prefetchData(at indexPath: IndexPath)

    func search(_ name: String)
    func playerTapped(at indexPath: IndexPath)
}

// MARK: Search Player Module View Controller

final class SearchPlayerModuleViewController: UIViewController {
    private var output: SearchPlayerModuleViewOutput?

    init(output: SearchPlayerModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
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
        updateState(.startScreen)
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
        searchBar.delegate = self
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
        return output?.countOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlayerTableViewCell.reuseIdentifier, for: indexPath) as? SearchPlayerTableViewCell else {
            return .init()
        }
        guard let player = output?.getData(at: indexPath) else {
            return cell
        }
        
        cell.configurePlayer(
            newAvatarImage: UIImage(named: "players")!,
            newNickname: player.personaname ?? "unknown",
            newTimeMatch: player.lastMatchTime?.debugDescription ?? "Offline"
        )
        cell.backgroundColor = indexPath.row % 2 == 0 ? ColorPalette.mainBackground : ColorPalette.alternativeBackground
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateState(.loading)
        output?.search(searchBar.text ?? "")
    }
}

// MARK: - SearchModuleViewInput

extension SearchPlayerModuleViewController: SearchPlayerModuleViewInput {
    func updateState(_ state: SearchPlayerModuleViewState) {
        switch state {
        case .startScreen:
            tableView.isHidden = true
        // TODO: start screen image
        case .empty:
            tableView.isHidden = true
        // TODO: imgae nothing have been founded
        case .loading:
            hideError()
            tableView.isHidden = true
            loadingCircle.startAnimating()
        // TODO: wait until Matvey make custom loading
        case .success:
            hideError()
            loadingCircle.stopAnimating()
            tableView.reloadData()
            tableView.isHidden = false
        case .failure:
            showError()
            // TODO: show error image
            print("error")
        }
    }

    func reload(at indexPath: IndexPath) {
        //
    }
}
