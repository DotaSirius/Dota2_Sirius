import UIKit

final class MainMatchInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MainMatchInfoTableViewCell"
    
    private let winnersLabel = UILabel()
    private let firstTeamScoreLabel = UILabel()
    private let secondTeamScoreLabel = UILabel()
    private let gameTimeLabel = UILabel()
    private let matchEndTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        [winnersLabel,gameTimeLabel,matchEndTimeLabel,firstTeamScoreLabel,secondTeamScoreLabel].forEach{contentView.addSubview($0)}
        
        winnersLabel.textColor = ColorPalette.win
        winnersLabel.font = UIFont.systemFont(ofSize: 30)
        winnersLabel.numberOfLines = 0
        winnersLabel.textAlignment = .center
        
        gameTimeLabel.textColor = ColorPalette.mainText
        gameTimeLabel.font = UIFont.systemFont(ofSize: 20)
        
        firstTeamScoreLabel.textColor = ColorPalette.win
        firstTeamScoreLabel.font = UIFont.systemFont(ofSize: 30)
        
        secondTeamScoreLabel.textColor = ColorPalette.lose
        secondTeamScoreLabel.font = UIFont.systemFont(ofSize: 30)
        
        matchEndTimeLabel.textColor = ColorPalette.subtitle
        matchEndTimeLabel.font = UIFont.systemFont(ofSize: 15)
        matchEndTimeLabel.numberOfLines = 0
        matchEndTimeLabel.textAlignment = .center
    }
    
    func setUpConstraints() {
        [winnersLabel,gameTimeLabel,matchEndTimeLabel,firstTeamScoreLabel,secondTeamScoreLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        winnersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        winnersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        winnersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        firstTeamScoreLabel.topAnchor.constraint(equalTo: winnersLabel.bottomAnchor, constant: 8).isActive = true
        firstTeamScoreLabel.trailingAnchor.constraint(equalTo: gameTimeLabel.leadingAnchor, constant: -16).isActive = true
        
        secondTeamScoreLabel.topAnchor.constraint(equalTo: winnersLabel.bottomAnchor, constant: 8).isActive = true
        secondTeamScoreLabel.leadingAnchor.constraint(equalTo: gameTimeLabel.trailingAnchor, constant: 16).isActive = true

        gameTimeLabel.centerYAnchor.constraint(equalTo: firstTeamScoreLabel.centerYAnchor).isActive = true
        gameTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        matchEndTimeLabel.topAnchor.constraint(equalTo: firstTeamScoreLabel.bottomAnchor, constant: 8).isActive = true
        matchEndTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        matchEndTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        matchEndTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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

