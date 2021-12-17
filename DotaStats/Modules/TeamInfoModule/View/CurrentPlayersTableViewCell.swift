//import UIKit
//
//final class MatchPlayerCell: UITableViewCell {
//    static let reuseIdentifier = "MatchPlayerCell"
//    let inset: CGFloat = 16
//    let smallInset: CGFloat = 8
//    let widthConstant: CGFloat = 30
//    
//    private let progressBar = UIProgressView()
//    private var progressPercent: Float = 0
//
//
//    private lazy var playerNameLabel: UILabel = {
//        let playerNameLabel = UILabel()
//        playerNameLabel.textColor = ColorPalette.mainText
//        playerNameLabel.font = UIFont.systemFont(ofSize: 17) // изменить шрифт
//        playerNameLabel.textAlignment = .left
//        playerNameLabel.numberOfLines = 2
//        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        return playerNameLabel
//    }()
//
//    private lazy var playerGamesLabel: UILabel = {
//        let playerGamesLabel = UILabel()
//        playerGamesLabel.textColor = ColorPalette.mainText
//        playerGamesLabel.font = UIFont.systemFont(ofSize: 17)
//        playerGamesLabel.textAlignment = .center
//        playerGamesLabel.translatesAutoresizingMaskIntoConstraints = false
//        return playerGamesLabel
//    }()
//
//    private lazy var playerWinrateLabel: UILabel = {
//        playerWinrateLabel = UILabel()
//        playerWinrateLabel.textColor = ColorPalette.lose
//        playerWinrateLabel.font = UIFont.systemFont(ofSize: 17)
//        playerWinrateLabel.textAlignment = .center
//        playerWinrateLabel.translatesAutoresizingMaskIntoConstraints = false
//        return playerWinrateLabel
//    }()
//
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setup()
//        setupConstraints()
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setup() {
//        [
//            
//        ].forEach {
//            contentView.addSubview($0)
//        }
//
//        [playerNameLabel,
//         playerRankLabel].forEach {
//            playerRankNameStack.addArrangedSubview($0)
//        }
//    }
//
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            playerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: smallInset),
//            playerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//            playerRankNameStack.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: smallInset),
//            playerRankNameStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
//            playerRankNameStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
//            playerRankNameStack.trailingAnchor.constraint(
//                equalTo: playerKillsLabel.leadingAnchor, constant: -smallInset
//            ),
//
//            playerGoldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            playerGoldLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
//            playerGoldLabel.widthAnchor.constraint(equalToConstant: widthConstant),
//
//            playerAssitsLabel.trailingAnchor.constraint(equalTo: playerGoldLabel.leadingAnchor, constant: -smallInset),
//            playerAssitsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
//            playerAssitsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
//
//            playerDeathsLabel.trailingAnchor.constraint(
//                equalTo: playerAssitsLabel.leadingAnchor, constant: -smallInset
//            ),
//            playerDeathsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
//            playerDeathsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
//
//            playerKillsLabel.trailingAnchor.constraint(equalTo: playerDeathsLabel.leadingAnchor, constant: -smallInset),
//            playerKillsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
//            playerKillsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor)
//        ])
//    }
//
//    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
//        stackView.axis = axis
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .leading
//        stackView.spacing = spacing
//    }
//}
//
//extension MatchPlayerCell: DetailedMatchInfoCellConfigurable {
//    func configure(with data: MatchTableViewCellData) {
//        switch data.type {
//        case .matchPlayerInfo(let data):
//            playerNameLabel.text = data.playerNameLabelText
//            playerDeathsLabel.text = data.playerDeathsText
//            playerRankLabel.text = data.playerRankText
//            playerKillsLabel.text = data.playerKillsText
//            playerAssitsLabel.text = data.playerAssitsText
//            playerGoldLabel.text = data.playerGoldText
//            playerImageView.image = data.playerImage
//        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
//        }
//    }
//}
