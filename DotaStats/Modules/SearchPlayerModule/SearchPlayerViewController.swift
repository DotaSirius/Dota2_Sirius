import Foundation
import UIKit

struct Data {
    let avatarImage: UIImage
    let nickname: String
    let raiting: Int
}

class SearchPlayerViewController: UIViewController {

    let data: [Data] = []

    // MARK: ActiviryEndicator

    var loadingCircle = UIActivityIndicatorView(style: .large)

    // MARK: ErrorView

    private lazy var ErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.mainText
        return label
    }()

    private lazy var ErrorView: UIView = {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30, height: 30))
        view.backgroundColor = ColorPalette.lose
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBarConstraints()
        setUpLoadingCircleConstraints()
        // loadingCircle.startAnimating()
        setUpTableConstraints()
        // tableView.isHidden = true // типо нет
    }

    // MARK: SearchBar Constraints

    private func setUpSearchBarConstraints() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: TableView Constraints

    private func setUpTableConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: LoadingCircle Constraints

    private func setUpLoadingCircleConstraints() {
        view.addSubview(loadingCircle)
        loadingCircle.color = ColorPalette.text
        loadingCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: ErrorView Constraints

    private func setUpErrorViewConstraints() {
        view.addSubview(ErrorView)
        view.addSubview(ErrorLabel)
        ErrorView.translatesAutoresizingMaskIntoConstraints = false
        ErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ErrorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ErrorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ErrorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(-30)),
            
            ErrorLabel.centerXAnchor.constraint(equalTo: ErrorView.centerXAnchor),
            ErrorLabel.centerYAnchor.constraint(equalTo: ErrorView.centerYAnchor)
        ])
    }

    // MARK: Change StatusBarStyle to light

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: extension for TableView

extension SearchPlayerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 // Данные из сети || нужно количество элеиентов в массиве
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlayerTableViewCell.reuseIdentifier, for: indexPath) as? SearchPlayerTableViewCell else {
            return .init()
        }
        ErrorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(0))
        cell.configurePlayer(UIImage(named: "Image")!, "Alex", "\(3500)")
        cell.backgroundColor = indexPath.row % 2 == 0 ? ColorPalette.mainBackground : UIColor.darkGray // example || надо вставить второй цвет из палетки
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

// MARK: extension for SearchBar

extension SearchPlayerViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // add if else with words check
    }
}
