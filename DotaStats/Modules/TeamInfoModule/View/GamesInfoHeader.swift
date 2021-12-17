import UIKit

final class GamesInfoHeader: UITableViewCell {
    static let reuseIdentifier = "GamesInfoHeader"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8
    let widthConstant: CGFloat = 30

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
        playerGamesLabel.textColor = ColorPalette.mainText
        playerGamesLabel.font = UIFont.systemFont(ofSize: 17)
        playerGamesLabel.textAlignment = .center
        playerGamesLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerGamesLabel
    }()

    private lazy var playerWinrateLabel: UILabel = {
        playerWinrateLabel = UILabel()
        playerWinrateLabel.textColor = ColorPalette.mainText
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
        ].forEach {
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            playerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),

            playerWinrateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playerWinrateLabel.widthAnchor.constraint(equalToConstant: 70),
            playerWinrateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),

            playerGamesLabel.trailingAnchor.constraint(equalTo: playerWinrateLabel.leadingAnchor, constant: -inset),
            playerGamesLabel.widthAnchor.constraint(equalToConstant: 70),
            playerGamesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset)
        ])
    }
}

extension GamesInfoHeader: DetailedTeamInfoCellConfigurable {
    func configure(with data: TeamInfoTableViewCellData) {
            playerNameLabel.text = "Name"
            playerGamesLabel.text = "Games"
            playerWinrateLabel.text = "Winrate"
    }
}
