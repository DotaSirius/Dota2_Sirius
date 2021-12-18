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
    private var searchDebouncerTimer: Timer?

    init(output: SearchPlayerModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(errorView)
        view.addSubview(startScreenImage)
        view.addSubview(emptyScreenImage)
        view.addSubview(errorScreenImage)

        errorView.isUserInteractionEnabled = true
        let tapActionHideError = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(_:))
        )
        errorView.addGestureRecognizer(tapActionHideError)

        setUpErrorViewConstraints()
        setUpSearchBarConstraints()
        setUpTableViewConstraints()
        setUpImagesConstraint(imageView: startScreenImage)
        setUpImagesConstraint(imageView: emptyScreenImage)
        setUpImagesConstraint(imageView: errorScreenImage)
        updateState(.startScreen)
    }

    // MARK: StartScreenImage

    private lazy var startScreenImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "startScreenImage")
        view.alpha = 0.5
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: EmptyScreenImage

    private lazy var emptyScreenImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "emptyImage")
        view.alpha = 0.5
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: ErrorScreenImage

    private lazy var errorScreenImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "errorImage")
        view.alpha = 0.5
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: Spinner

    private lazy var loadingView = SquareLoadingView()

    // MARK: ErrorView

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.alpha = 0
        return view
    }()

    // MARK: UITableView

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchPlayerTableViewCell.self,
                           forCellReuseIdentifier: SearchPlayerTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorPalette.mainBackground
        tableView.separatorColor = ColorPalette.separator
        tableView.rowHeight = 70
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
        searchBar.placeholder = "Enter a nickname..."
        searchBar.showsCancelButton = false
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

    // MARK: setImagesConstraint

    private func setUpImagesConstraint(imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 40
            ),
            imageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -40
            ),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut]) {
            self.errorConstraint?.constant = 35
            self.errorView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    func hideError() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut]) {
            self.errorConstraint?.constant = 0
            self.errorView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }

    @objc func handleTap(_: UITapGestureRecognizer) {
        hideError()
        updateState(.startScreen)
    }
}

// MARK: extension for TableView

extension SearchPlayerModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.countOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchPlayerTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? SearchPlayerTableViewCell else {
            return .init()
        }
        guard let player = output?.getData(at: indexPath) else {
            return cell
        }

        cell.configurePlayer(
            newAvatarImageURL: player.avatarFull,
            newNickname: player.personaname ?? "unknown",
            newTimeMatch: player.lastMatchTime,
            indexPath: indexPath
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDebouncerTimer?.invalidate()

        let timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: false
        ) { [weak self] _ in
            self?.fireTimer()
        }

        searchDebouncerTimer = timer
    }

    private func fireTimer() {
        if searchBar.text?.isEmpty ?? true {
            updateState(.startScreen)
        } else {
            output?.search(searchBar.text ?? "")
        }
    }
}

// MARK: - SearchModuleViewInput

extension SearchPlayerModuleViewController: SearchPlayerModuleViewInput {
    func updateState(_ state: SearchPlayerModuleViewState) {
        switch state {
        case .startScreen:
            loadingView.stopAnimation()
            tableView.isHidden = true
            startScreenImage.isHidden = false
            emptyScreenImage.isHidden = true
            errorScreenImage.isHidden = true
        case .empty:
            emptyScreenImage.isHidden = false
            startScreenImage.isHidden = true
            errorScreenImage.isHidden = true
            tableView.isHidden = true
        case .loading:
            startScreenImage.isHidden = true
            emptyScreenImage.isHidden = true
            errorScreenImage.isHidden = true
            hideError()
            tableView.isHidden = true
            view.addSubview(loadingView)
            loadingView.center = view.center
            loadingView.startAnimation()
        case .success:
            hideError()
            loadingView.stopAnimation()
            tableView.reloadData()
            tableView.isHidden = false
            emptyScreenImage.isHidden = true
            startScreenImage.isHidden = true
            errorScreenImage.isHidden = true
        case .failure:
            showError()
            loadingView.stopAnimation()
            emptyScreenImage.isHidden = true
            startScreenImage.isHidden = true
            errorScreenImage.isHidden = false
        }
    }

    func reload(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
