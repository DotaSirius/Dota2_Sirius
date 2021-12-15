import UIKit

final class TeamsCell: UITableViewCell {
    static let identifier = "TeamsCell"

    private enum Constant {
        static let verticalPadding: CGFloat = 15
        static let spacing: CGFloat = 10
        static let mainFointSize: CGFloat = 17
        static let additionalInfoFontSize: CGFloat = 13
        static let numWidth: CGFloat = 20
        static let avatarSide: CGFloat = 40
        static let winRateWidth: CGFloat = 90
        static let ratingWidth: CGFloat = 60
    }

    private lazy var numTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.additionalInfoFontSize, weight: .bold)
        label.numberOfLines = 1
        label.textColor = ColorPalette.text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamLogoView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.mainFointSize, weight: .bold)
        label.numberOfLines = 2
        label.textColor = ColorPalette.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recentActivityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.additionalInfoFontSize, weight: .bold)
        label.numberOfLines = 1
        label.textColor = ColorPalette.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.additionalInfoFontSize, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var winRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.additionalInfoFontSize, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrlString: String,
                   numOfTeam: Int,
                   teamName: String = "Team Spirit",
                   recentActivity: String = "a day ago",
                   rating: Int = 1200,
                   ratingColor: UIColor = .green,
                   winPercent: Double = 56.7,
                   winPercentColor: UIColor = .yellow) {
        
        numTeamLabel.text = getNumFromIndexPathRow(numOfTeam)
        teamLogoView.setImage(with: imageUrlString)
        teamNameLabel.text = teamName
        recentActivityLabel.text = recentActivity
        ratingLabel.text = String(rating)
        ratingLabel.textColor = ratingColor
        winRateLabel.text = String(winPercent) + "%"
        winRateLabel.textColor = winPercentColor
    }

    private func setup() {
        backgroundColor = ColorPalette.mainBackground
        contentView.addSubview(numTeamLabel)
        contentView.addSubview(teamLogoView)
        contentView.addSubview(recentActivityLabel)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(winRateLabel)

        let bottomConstraint = teamLogoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                              constant: -Constant.spacing)
        bottomConstraint.priority = UILayoutPriority(rawValue: 300)

        NSLayoutConstraint.activate([
            numTeamLabel.widthAnchor.constraint(equalToConstant: Constant.numWidth),
            numTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.spacing),
            numTeamLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamLogoView.widthAnchor.constraint(equalToConstant: Constant.avatarSide),
            teamLogoView.heightAnchor.constraint(equalToConstant: Constant.avatarSide),
            teamLogoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.verticalPadding),
            teamLogoView.leadingAnchor.constraint(equalTo: numTeamLabel.trailingAnchor, constant: Constant.verticalPadding),
            bottomConstraint,

            teamNameLabel.leadingAnchor.constraint(equalTo: teamLogoView.trailingAnchor, constant: Constant.spacing),
            teamNameLabel.topAnchor.constraint(equalTo: teamLogoView.topAnchor),
            teamNameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: Constant.spacing),

            recentActivityLabel.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor),
            recentActivityLabel.leadingAnchor.constraint(equalTo: teamNameLabel.leadingAnchor),
            
            ratingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: winRateLabel.leadingAnchor, constant: Constant.spacing),
            ratingLabel.widthAnchor.constraint(equalToConstant: Constant.ratingWidth),
 
            winRateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            winRateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constant.spacing),
            winRateLabel.widthAnchor.constraint(equalToConstant: Constant.winRateWidth)
        ])
    }
}

func getNumFromIndexPathRow(_ num: Int) -> String {
    switch num {
    case 0:
        return "🥇"
    case 1:
        return "🥈"
    case 2:
        return "🥉"
    default:
        return "\(num + 1)"
    }
}
