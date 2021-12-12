import UIKit

class MatchPlayerCell: UITableViewCell {

    static let reuseIdentifier = "MatchPlayerCell"
    
    let playerImageView: UIImageView = {
        let playerImageView = UIImageView()
        playerImageView.contentMode = .scaleAspectFit
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        playerImageView.clipsToBounds = true
        playerImageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        playerImageView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return playerImageView
    }()

    private let playerRankNameStack = UIStackView()
    private let playerMainInfoStack = UIStackView()
    
    private let playerNameLabel = UILabel()
    private let playerRankLabel = UILabel()
    private let playerKillsLabel = UILabel()
    private let playerDeathsLabel = UILabel()
    private let playerAssitsLabel = UILabel()
    private let playerGoldLabel = UILabel()
    

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
        contentView.backgroundColor = ColorPalette.mainBackground
        [playerMainInfoStack].forEach { contentView.addSubview($0) }

        playerNameLabel.textColor = ColorPalette.mainText
        playerNameLabel.font = UIFont.systemFont(ofSize: 20) // изменить шрифт
        
        playerRankLabel.textColor = ColorPalette.subtitle
        playerRankLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        playerKillsLabel.textColor = ColorPalette.win
        playerKillsLabel.font = UIFont.systemFont(ofSize: 15)
        
        playerDeathsLabel.textColor = ColorPalette.lose
        playerDeathsLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        playerAssitsLabel.textColor = ColorPalette.subtitle
        playerAssitsLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        playerGoldLabel.textColor = ColorPalette.accent
        playerGoldLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
    }

    func setUpConstraints() {
        [playerMainInfoStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        createStackView(stackView: playerRankNameStack, axis: .vertical, spacing: 8)
        [playerNameLabel, playerRankLabel].forEach{playerRankNameStack.addArrangedSubview($0)}
        
        createStackView(stackView: playerMainInfoStack, axis: .horizontal, spacing: 3)
        [playerImageView, playerRankNameStack, playerKillsLabel, playerDeathsLabel, playerAssitsLabel, playerGoldLabel].forEach{playerMainInfoStack.addArrangedSubview($0)}
        
        playerMainInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        playerMainInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        playerMainInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        playerMainInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func createStackView(stackView:UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
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
//    func configure(with data: String) {
//        playerKills.text = "9"// данные придут из сети
//        playerDeaths.text = "25"// данные придут из сети
//        playerAssits.text = "3"
//        playerNameLabel.text = "PlayerName"// данные придут из сети
//        playerImageView.image = UIImage(named: "morphling.png")// данные придут из сети
//        playerRank.text = "Immotral"
//        playerGold.text = "5.7k"
//    }
}
