import UIKit

final class MainMatchInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MainMatchInfoTableViewCell"
    
    private lazy var  winnersLabel: UILabel = {
        let winnersLabel = UILabel()
        winnersLabel.textColor = ColorPalette.win
        winnersLabel.font = UIFont.systemFont(ofSize: 30)
        winnersLabel.numberOfLines = 3
        winnersLabel.textAlignment = .center
        return winnersLabel
    }()
    
    private lazy var  firstTeamScoreLabel: UILabel = {
        let firstTeamScoreLabel = UILabel()
        firstTeamScoreLabel.textColor = ColorPalette.win
        firstTeamScoreLabel.font = UIFont.systemFont(ofSize: 30)
        return firstTeamScoreLabel
    }()
    
    private lazy var  secondTeamScoreLabel: UILabel = {
        let secondTeamScoreLabel = UILabel()
        secondTeamScoreLabel.textColor = ColorPalette.lose
        secondTeamScoreLabel.font = UIFont.systemFont(ofSize: 30)
        return secondTeamScoreLabel
    }()
    
    private lazy var  gameTimeLabel: UILabel = {
        let gameTimeLabel = UILabel()
        gameTimeLabel.textColor = ColorPalette.mainText
        gameTimeLabel.font = UIFont.systemFont(ofSize: 20)
        return gameTimeLabel
    }()
    
    private lazy var  matchEndTimeLabel: UILabel = {
        let matchEndTimeLabel = UILabel()
        matchEndTimeLabel.textColor = ColorPalette.subtitle
        matchEndTimeLabel.font = UIFont.systemFont(ofSize: 15)
        matchEndTimeLabel.numberOfLines = 3
        matchEndTimeLabel.textAlignment = .center
        return matchEndTimeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        selectionStyle = .none
        [winnersLabel,
         gameTimeLabel,
         matchEndTimeLabel,
         firstTeamScoreLabel,
         secondTeamScoreLabel
        ].forEach{
            contentView.addSubview($0)
        }
    }
    
    func setUpConstraints() {
        [winnersLabel,
         gameTimeLabel,
         matchEndTimeLabel,
         firstTeamScoreLabel,
         secondTeamScoreLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            winnersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            winnersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            winnersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            firstTeamScoreLabel.topAnchor.constraint(equalTo: winnersLabel.bottomAnchor, constant: 8),
            firstTeamScoreLabel.trailingAnchor.constraint(equalTo: gameTimeLabel.leadingAnchor, constant: -16),
            
            secondTeamScoreLabel.topAnchor.constraint(equalTo: winnersLabel.bottomAnchor, constant: 8),
            secondTeamScoreLabel.leadingAnchor.constraint(equalTo: gameTimeLabel.trailingAnchor, constant: 16),

            gameTimeLabel.centerYAnchor.constraint(equalTo: firstTeamScoreLabel.centerYAnchor),
            gameTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            matchEndTimeLabel.topAnchor.constraint(equalTo: firstTeamScoreLabel.bottomAnchor, constant: 8),
            matchEndTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            matchEndTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            matchEndTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension MainMatchInfoTableViewCell:  DetailedMatchInfoCellConfigurable {
        func configure(with data: MatchTableViewCellData) {
            switch data.type {
            case .mainMatchInfo(let data):
                winnersLabel.text = data.winnersLabelText
                gameTimeLabel.text = data.gameTimeLabelText
                firstTeamScoreLabel.text = data.firstTeamScoreLabelText
                secondTeamScoreLabel.text = data.secondTeamScoreLabelText
                matchEndTimeLabel.text = data.matchEndTimeLabelText
            default : break //TO DO: заменить break
            }
    }
}

