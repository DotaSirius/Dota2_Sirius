import UIKit

class MatchViewController: UIViewController {
    private let colorPalette = ColorPalette()

    var data: MatchTableViewCellData?
    
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

extension MatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15 // данные из сети
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = getCellData(indexpath: indexPath.row)
        let reuseIdentifier = data.type.reuseIdentificator
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: reuseIdentifier,
                for: indexPath) as? (UITableViewCell & DetailedMatchInfoCellConfigurable)
        else {
            return UITableViewCell()
        }
        cell.configure(with: data)
        return cell
    }
    
}
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let reuseIdentifier = "MatchPlayerCell"
//        guard
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: reuseIdentifier,
//                for: indexPath) as? (UITableViewCell & DetailedMatchInfoCellConfigurable)
//        else {
//            return UITableViewCell()
//        }
//        let data = ""
//        cell.configure(with: data)
//        return cell
//    }
