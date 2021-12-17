import UIKit

final class CurrentPlayersCell: UITableViewCell {
    static let reuseIdentifier = "CurrentPlayersCell"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8
    let widthConstant: CGFloat = 30

    private let gamesProgressBar = UIProgressView()
    private let winRateProgressBar = UIProgressView()
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
            playerWinrateLabel,
            gamesProgressBar,
            winRateProgressBar
        ].forEach {
            contentView.addSubview($0)
        }
        gamesProgressBar.trackTintColor = ColorPalette.subtitle
        gamesProgressBar.tintColor = ColorPalette.win
        
        winRateProgressBar.trackTintColor = ColorPalette.subtitle
        winRateProgressBar.tintColor = ColorPalette.win
    }

    func setupConstraints() {
        gamesProgressBar.translatesAutoresizingMaskIntoConstraints = false
        winRateProgressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),

            playerWinrateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playerWinrateLabel.widthAnchor.constraint(equalToConstant: 70),
            playerWinrateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),

            playerGamesLabel.trailingAnchor.constraint(equalTo: playerWinrateLabel.leadingAnchor, constant: -inset),
            playerGamesLabel.widthAnchor.constraint(equalToConstant: 70),
            playerGamesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),

            gamesProgressBar.topAnchor.constraint(equalTo: playerGamesLabel.bottomAnchor),
            gamesProgressBar.centerXAnchor.constraint(equalTo: playerGamesLabel.centerXAnchor),
            gamesProgressBar.widthAnchor.constraint(equalToConstant: 70),
            
            winRateProgressBar.topAnchor.constraint(equalTo: playerWinrateLabel.bottomAnchor),
            winRateProgressBar.centerXAnchor.constraint(equalTo: playerWinrateLabel.centerXAnchor),
            winRateProgressBar.widthAnchor.constraint(equalToConstant: 70)
            
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
            let playersGamesCount = Float(data.gamesLabelText) ?? 0
            progressPercent = playersGamesCount/Float(data.maxGamesAmount)
            UIView.animate(withDuration: 0.4) {
                self.gamesProgressBar.setProgress(self.progressPercent, animated: true)
                        }
            let playersWinrateCount = Float(data.winrateLabelText) ?? 0
            progressPercent = playersWinrateCount/Float(100)
            UIView.animate(withDuration: 0.4) {
                self.winRateProgressBar.setProgress(self.progressPercent, animated: true)
                        }
            
        case .currentHeroesInfo(let data):
            playerNameLabel.text = data.heroesNameLabelText
            playerGamesLabel.text = data.heroesGamesLabelText
            playerWinrateLabel.text = data.heroesWinrateLabelText
            let herousGamesCount = Float(data.heroesGamesLabelText) ?? 0
            progressPercent = herousGamesCount/Float(data.heroesMaxGameCount)
            UIView.animate(withDuration: 0.4) {
                self.gamesProgressBar.setProgress(self.progressPercent, animated: true)
                        }
            let playersWinrateCount = Float(data.heroesWinrateLabelText) ?? 0
            progressPercent = playersWinrateCount/Float(100)
            UIView.animate(withDuration: 0.4) {
                self.winRateProgressBar.setProgress(self.progressPercent, animated: true)
                        }
        case .currentHeroesHeader:
            playerNameLabel.text = "Hero"
            playerGamesLabel.text = "Games"
            playerWinrateLabel.text = "Winrate"
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}

