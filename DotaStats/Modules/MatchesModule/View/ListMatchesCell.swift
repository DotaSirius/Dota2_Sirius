import UIKit

final class ListMatchesCell: UITableViewCell {
    static let reuseIdentifier = "ListMatchesCell"
    
    lazy var firstTeam: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .right
        label.textColor = ColorPalette.win
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    lazy var secondTeam: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.textColor = ColorPalette.lose
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    lazy var score: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    func setup() {
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
