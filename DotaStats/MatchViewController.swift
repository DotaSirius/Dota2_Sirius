import UIKit

class MatchViewController: UIViewController {
    private let colorPalette = ColorPalette()

    var data: MatchTableViewData?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AdditionalMatchInfoTableViewCell.self, forCellReuseIdentifier: AdditionalMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MainMatchInfoTableViewCell.self, forCellReuseIdentifier: MainMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MatchPlayerCell.self, forCellReuseIdentifier: MatchPlayerCell.reuseIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = colorPalette.mainBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorPalette.mainBackground
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

extension MatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 //data?.collectionContent.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "MainMatchInfoTableViewCell"
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: reuseIdentifier,
                for: indexPath) as? (UITableViewCell & DetailedMatchInfoCellConfigurable)
        else {
            return UITableViewCell()
        }
        let data = ""
        cell.configure(with: data)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let reuseIdentifier = data?.tableContent[indexPath.row].reuseIdentifier else {
//                return UITableViewCell()
//            }
//        guard
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: reuseIdentifier,
//                for: indexPath) as? (UITableViewCell & DetailedMatchInfoCellConfigurable),
//            let data = data?.TableContent[indexPath.row].type
//        else {
//            return UITableViewCell()
//        }
//        cell.configure(with: data)
//        return cell
//    }
    
}
