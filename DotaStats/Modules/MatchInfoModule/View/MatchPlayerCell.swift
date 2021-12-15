import UIKit

final class MatchPlayerCell: UITableViewCell {

    static let reuseIdentifier = "MatchPlayerCell"
    
    private lazy var playerImageView: UIImageView = {
        let playerImageView = UIImageView()
        playerImageView.contentMode = .scaleAspectFit
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        playerImageView.clipsToBounds = true
        playerImageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        playerImageView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return playerImageView
    }()
    
    private lazy var playerRankNameStack: UIStackView = {
        let playerRankNameStack = UIStackView()
        createStackView(stackView: playerRankNameStack, axis: .vertical, spacing: 8)
        return playerRankNameStack
    }()
    
    private lazy var playerNameLabel: UILabel = {
        let playerNameLabel = UILabel()
        playerNameLabel.textColor = ColorPalette.mainText
        playerNameLabel.font = UIFont.systemFont(ofSize: 17)// изменить шрифт
        playerNameLabel.textAlignment = .left
        playerNameLabel.numberOfLines = 2
        return playerNameLabel
    }()
    
    private lazy var playerRankLabel: UILabel = {
        let playerRankLabel = UILabel()
        playerRankLabel.textColor = ColorPalette.subtitle
        playerRankLabel.font = UIFont.systemFont(ofSize: 17) // изменить шрифт
        playerRankLabel.textAlignment = .center
        playerRankLabel.numberOfLines = 3
        return playerRankLabel
    }()
    
    private lazy var playerKillsLabel: UILabel = {
        let playerKillsLabel = UILabel()
        playerKillsLabel.textColor = ColorPalette.win
        playerKillsLabel.font = UIFont.systemFont(ofSize: 17)
        playerKillsLabel.textAlignment = .center
        return playerKillsLabel
    }()
    
    private lazy var playerDeathsLabel: UILabel = {
        let playerDeathsLabel = UILabel()
        playerDeathsLabel.textColor = ColorPalette.lose
        playerDeathsLabel.font = UIFont.systemFont(ofSize: 17)
        playerDeathsLabel.textAlignment = .center
        return playerDeathsLabel
    }()
    
    private lazy var playerAssitsLabel: UILabel = {
        let playerAssitsLabel = UILabel()
        playerAssitsLabel.textColor = ColorPalette.subtitle
        playerAssitsLabel.font = UIFont.systemFont(ofSize: 17)
        playerAssitsLabel.textAlignment = .center
        return playerAssitsLabel
    }()
    
    private lazy var playerGoldLabel: UILabel = {
        let playerGoldLabel = UILabel()
        playerGoldLabel.textColor = ColorPalette.accent
        playerGoldLabel.font = UIFont.systemFont(ofSize: 17)
        playerGoldLabel.textAlignment = .center
        return playerGoldLabel
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
        [
            playerImageView,
            playerRankNameStack,
            playerGoldLabel,
            playerAssitsLabel,
            playerDeathsLabel,
            playerKillsLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        [playerNameLabel,
         playerRankLabel
        ].forEach{
            playerRankNameStack.addArrangedSubview($0)
        }
    }

    func setUpConstraints() {
        [
            playerImageView,
            playerRankNameStack,
            playerGoldLabel,
            playerAssitsLabel,
            playerDeathsLabel,
            playerKillsLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            playerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            playerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playerRankNameStack.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 8),
            playerRankNameStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            playerRankNameStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            playerRankNameStack.trailingAnchor.constraint(equalTo: playerKillsLabel.leadingAnchor, constant: -8),
            
            playerGoldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            playerGoldLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
            playerGoldLabel.widthAnchor.constraint(equalToConstant: 30),
            
            playerAssitsLabel.trailingAnchor.constraint(equalTo: playerGoldLabel.leadingAnchor, constant: -8),
            playerAssitsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
            playerAssitsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
            
            playerDeathsLabel.trailingAnchor.constraint(equalTo: playerAssitsLabel.leadingAnchor, constant: -8),
            playerDeathsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
            playerDeathsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
            
            playerKillsLabel.trailingAnchor.constraint(equalTo: playerDeathsLabel.leadingAnchor, constant: -8),
            playerKillsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
            playerKillsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
        ])
    }
    
    func createStackView(stackView:UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = spacing
    }
}

extension MatchPlayerCell: DetailedMatchInfoCellConfigurable {
    
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .matchPlayerInfo(let data):
            playerNameLabel.text = data.playerNameLabelText
            playerDeathsLabel.text  = data.playerDeathsText
            playerRankLabel.text = data.playerRankText
            playerKillsLabel.text = data.playerKillsText
            playerAssitsLabel.text = data.playerAssitsText
            playerGoldLabel.text = data.playerGoldText
            playerImageView.image = data.playerImage
        default : break
        }
    }
}
