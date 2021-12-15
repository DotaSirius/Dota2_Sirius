import UIKit

final class ListMatchesCell: UITableViewCell {
    // MARK: - Properties
    
    static let reuseIdentifier = "ListMatchesCell"

    private lazy var firstTeam: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .right
        label.textColor = ColorPalette.win
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    private lazy var secondTeam: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.textColor = ColorPalette.lose
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    private lazy var score: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cell configuration
    
    func configure(with data: TournamentViewState.Match) {
        firstTeam.text = data.radiantTeam
        secondTeam.text = data.direTeam
        score.text = data.score
    }

    // MARK: - Setup constrains
    
    private func setup() {
        backgroundColor = ColorPalette.alternativeBackground

        contentView.addSubview(firstTeam)
        contentView.addSubview(secondTeam)
        contentView.addSubview(score)

        NSLayoutConstraint.activate([
            score.centerYAnchor.constraint(equalTo: centerYAnchor),
            score.centerXAnchor.constraint(equalTo: centerXAnchor),
            score.widthAnchor.constraint(equalToConstant: 50),

            firstTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
            firstTeam.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            firstTeam.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            secondTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondTeam.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 50),
            secondTeam.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
