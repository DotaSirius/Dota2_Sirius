import UIKit

final class PlayersTableHeaderCell: UITableViewCell {
    static let reuseIdentifier = "PlayersTableHeaderCell"

    private lazy var playerNameHeaderLabel: UILabel = {
        let playerNameHeaderLabel = UILabel()
        playerNameHeaderLabel.textColor = ColorPalette.mainText
        playerNameHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerNameHeaderLabel.textAlignment = .center
        return playerNameHeaderLabel
    }()

    private lazy var playerKillsHeaderLabel: UILabel = {
        let playerKillsHeaderLabel = UILabel()
        playerKillsHeaderLabel.textColor = ColorPalette.win
        playerKillsHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerKillsHeaderLabel.textAlignment = .center
        return playerKillsHeaderLabel
    }()

    private lazy var playerDeathsHeaderLabel: UILabel = {
        let playerDeathsHeaderLabel = UILabel()
        playerDeathsHeaderLabel.textColor = ColorPalette.lose
        playerDeathsHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerDeathsHeaderLabel.textAlignment = .center
        return playerDeathsHeaderLabel
    }()

    private lazy var playerAssitsHeaderLabel: UILabel = {
        let playerAssitsHeaderLabel = UILabel()
        playerAssitsHeaderLabel.textColor = ColorPalette.subtitle
        playerAssitsHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerAssitsHeaderLabel.textAlignment = .center
        return playerAssitsHeaderLabel
    }()

    private lazy var playerGoldHeaderLabel: UILabel = {
        let playerGoldHeaderLabel = UILabel()
        playerGoldHeaderLabel.textColor = ColorPalette.accent
        playerGoldHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        playerGoldHeaderLabel.textAlignment = .center
        return playerGoldHeaderLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setUpConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        selectionStyle = .none
        [
            playerNameHeaderLabel,
            playerGoldHeaderLabel,
            playerAssitsHeaderLabel,
            playerDeathsHeaderLabel,
            playerKillsHeaderLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }

    func setUpConstraints() {
        [
            playerNameHeaderLabel,
            playerGoldHeaderLabel,
            playerAssitsHeaderLabel,
            playerDeathsHeaderLabel,
            playerKillsHeaderLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            playerNameHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            playerNameHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            playerNameHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            playerNameHeaderLabel.trailingAnchor.constraint(equalTo: playerKillsHeaderLabel.leadingAnchor),

            playerGoldHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            playerGoldHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            playerGoldHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            playerGoldHeaderLabel.widthAnchor.constraint(equalToConstant: 30),

            playerAssitsHeaderLabel.trailingAnchor.constraint(
                equalTo: playerGoldHeaderLabel.leadingAnchor, constant: -8
            ),
            playerAssitsHeaderLabel.widthAnchor.constraint(equalTo: playerGoldHeaderLabel.widthAnchor),
            playerAssitsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            playerAssitsHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            playerDeathsHeaderLabel.trailingAnchor.constraint(
                equalTo: playerAssitsHeaderLabel.leadingAnchor, constant: -8
            ),
            playerDeathsHeaderLabel.widthAnchor.constraint(equalTo: playerGoldHeaderLabel.widthAnchor),
            playerDeathsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            playerDeathsHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            playerKillsHeaderLabel.trailingAnchor.constraint(
                equalTo: playerDeathsHeaderLabel.leadingAnchor, constant: -8
            ),
            playerKillsHeaderLabel.widthAnchor.constraint(equalTo: playerGoldHeaderLabel.widthAnchor),
            playerKillsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            playerKillsHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }
}

extension PlayersTableHeaderCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        playerNameHeaderLabel.text = "Player"
        playerKillsHeaderLabel.text = "K"
        playerDeathsHeaderLabel.text = "D"
        playerAssitsHeaderLabel.text = "A"
        playerGoldHeaderLabel.text = "NET"
    }
}
