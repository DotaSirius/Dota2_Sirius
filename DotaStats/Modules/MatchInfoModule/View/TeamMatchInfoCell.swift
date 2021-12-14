import UIKit

final class TeamMatchInfoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TeamMatchInfoTableViewCell"
    
    private let teamNameLabel = UILabel()
    private let teamWinLabel = UILabel()
    private let teamNameWinStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        [teamNameWinStack].forEach{contentView.addSubview($0)}
        
        teamNameLabel.textColor = ColorPalette.mainText
        teamNameLabel.font = UIFont.systemFont(ofSize: 20) //изменить шрифт
        teamNameLabel.numberOfLines = 0
        teamNameLabel.textAlignment = .center
        
        teamWinLabel.textColor = ColorPalette.win
        teamWinLabel.font = UIFont.systemFont(ofSize: 20) //изменить шрифт
        
        
        createStackView(stackView: teamNameWinStack, axis: .horizontal, spacing: 8)
        [teamNameLabel, teamWinLabel].forEach { teamNameWinStack.addArrangedSubview($0) }
    }
                                    
    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = spacing
}
    
     func setUpConstraints() {
        [teamNameWinStack].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
         teamNameWinStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
         teamNameWinStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
         teamNameWinStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
         teamNameWinStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
         
    }
}

extension TeamMatchInfoTableViewCell:  DetailedMatchInfoCellConfigurable {
        func configure(with data: MatchTableViewCellData) {
            switch data.type {
            case .teamMatchInfo(let data):
                teamNameLabel.text = data.teamNameLabelText
                teamWinLabel.text = data.teamWinLabel
            default : break
           }
        }
    }
