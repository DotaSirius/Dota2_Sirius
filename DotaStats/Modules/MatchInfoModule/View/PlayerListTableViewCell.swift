////
////  PlayerList.swift
////  DotaStats
////
////  Created by Костина Вероника  on 10.12.2021.
////
//
//import UIKit
//class PlayerListTableViewCell: UITableViewCell {
//    static let reuseIdentifier = "PlayerListTableViewCell"
//    private let colorPalette = ColorPalette()
//    var playerName = String()
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(MatchPlayerCell.self, forCellReuseIdentifier: MatchPlayerCell.reuseIdentifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = colorPalette.mainBackground
//        return tableView
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setup()
//        setUpConstraints()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setup() {
//        [tableView].forEach{contentView.addSubview($0)}
//    }
//
//        func setUpConstraints() {
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//}
//
//extension PlayerListTableViewCell: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5 //Данные придут из сети, но вообще в одной катке всегда 5 человек (вроде)
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchPlayerCell.reuseIdentifier, for: indexPath) as? MatchPlayerCell else {
//            return .init()
//        }
//        //cell.configure(name: playerName)
//        return cell
//    }
//
//}
//
//extension PlayerListTableViewCell: DetailedMatchInfoCellConfigurable {
////    func configure(with data: MatchTableViewCellType) {
////        playerName = "Player" //данные придут из сети
////    }
//
//        func configure(with data: String) {
//            playerName = "Player" //данные придут из сети
//        }
//}
