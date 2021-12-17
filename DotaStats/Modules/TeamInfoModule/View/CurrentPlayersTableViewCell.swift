import UIKit

final class CurrentPlayersCell: UITableViewCell {
    static let reuseIdentifier = "MatchPlayerCell"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8
    let widthConstant: CGFloat = 30

    private let gamesProgressBar = UIProgressView()
    private var progressPercent: Float = 0

    private lazy var playerNameLabel: UILabel = {
        let playerNameLabel = UILabel()
        playerNameLabel.textColor = ColorPalette.mainText
        playerNameLabel.font = UIFont.systemFont(ofSize: 17) // изменить шрифт
        playerNameLabel.textAlignment = .left
        playerNameLabel.numberOfLines = 2
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerNameLabel
    }()

    private lazy var playerGamesLabel: UILabel = {
        let playerGamesLabel = UILabel()
        playerGamesLabel.textColor = ColorPalette.text
        playerGamesLabel.font = UIFont.systemFont(ofSize: 17)
        playerGamesLabel.textAlignment = .center
        playerGamesLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerGamesLabel
    }()

    private lazy var playerWinrateLabel: UILabel = {
        playerWinrateLabel = UILabel()
        playerWinrateLabel.textColor = ColorPalette.text
        playerWinrateLabel.font = UIFont.systemFont(ofSize: 17)
        playerWinrateLabel.textAlignment = .center
        playerWinrateLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerWinrateLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        [
            playerNameLabel,
            playerGamesLabel,
            playerWinrateLabel
//            gamesProgressBar
        ].forEach {
            contentView.addSubview($0)
        }
//        gamesProgressBar.trackTintColor = ColorPalette.alternativeBackground
//        gamesProgressBar.tintColor = ColorPalette.win
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            playerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),

            playerWinrateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playerWinrateLabel.widthAnchor.constraint(equalToConstant: 50),
            playerWinrateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),

            playerGamesLabel.trailingAnchor.constraint(equalTo: playerWinrateLabel.leadingAnchor, constant: -inset),
            playerGamesLabel.widthAnchor.constraint(equalToConstant: 50),
            playerGamesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset)

//            gamesProgressBar.topAnchor.constraint(equalTo: playerGamesLabel.bottomAnchor, constant: -inset),
//            gamesProgressBar.leadingAnchor.constraint(equalTo: playerGamesLabel.leadingAnchor),
//            gamesProgressBar.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension CurrentPlayersCell: DetailedTeamInfoCellConfigurable {
    func configure(with data: TeamInfoTableViewCellData) {
        switch data.type {
        case .currentPlayersInfo(let data):
            playerNameLabel.text = data.playerNameLabelText
            playerGamesLabel.text = data.gamesLabelText
            playerWinrateLabel.text = data.winrateLabelText
        case .currentHeroesInfo(let data):
            playerNameLabel.text = data.heroesNameLabelText
            playerGamesLabel.text = data.heroesGamesLabelText
            playerWinrateLabel.text = data.heroesWinrateLabelText

//            progressPercent = data.playerGamesAmount/data.maxGamesAmount
//            UIView.animate(withDuration: 0.4) {
//                self.gamesProgressBar.setProgress(self.progressPercent, animated: true)
//            }
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
