import UIKit

final class TeamsInfoMatchesHeader: UITableViewCell {
    // MARK: - Properties

    static let reuseIdentifier = "TeamsInfoMatches"

    private lazy var number: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .right
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var results: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var duration: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var enemy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
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

    // MARK: - Setup constrains

    private func setup() {
        backgroundColor = ColorPalette.mainBackground

        contentView.addSubview(number)
        contentView.addSubview(duration)
        contentView.addSubview(results)
        contentView.addSubview(enemy)

        NSLayoutConstraint.activate([
            number.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            number.centerYAnchor.constraint(equalTo: centerYAnchor),
            number.widthAnchor.constraint(equalToConstant: 70),

            duration.trailingAnchor.constraint(equalTo: results.leadingAnchor, constant: -20),
            duration.centerYAnchor.constraint(equalTo: centerYAnchor),
            duration.widthAnchor.constraint(equalToConstant: 70),

            results.trailingAnchor.constraint(equalTo: enemy.leadingAnchor, constant: -15),
            results.centerYAnchor.constraint(equalTo: centerYAnchor),
            results.widthAnchor.constraint(equalToConstant: 70),

            enemy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            enemy.centerYAnchor.constraint(equalTo: centerYAnchor),
            enemy.widthAnchor.constraint(equalToConstant: 70)

        ])
    }
}

extension TeamsInfoMatchesHeader: DetailedTeamInfoCellConfigurable {
    // MARK: - Cell configuration

    func configure(with data: TeamInfoTableViewCellData) {
        number.text = "Matches"
        duration.text = "Duration"
        results.text = "Result"
        enemy.text = "Enemy"
    }
}
