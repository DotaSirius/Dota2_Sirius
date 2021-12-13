import UIKit


class ListMatchesCell: UITableViewCell {
    
    static let reuseIdentifier = "ListMatchesCell"
    
    lazy var firstTeam: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .center
        control.textColor = ColorPalette.win
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3;
        control.textAlignment = .natural
        return control
        
    }()
    
    lazy var secondTeam: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .center
        control.textColor = ColorPalette.lose
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3;
        control.textAlignment = .natural
        return control
        
    }()
    
    lazy var score: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        control.textAlignment = .center
        control.textColor = ColorPalette.mainText
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
    
    func addView() {
        contentView.addSubview(firstTeam)
        contentView.addSubview(secondTeam)
        contentView.addSubview(score)
        
        NSLayoutConstraint.activate([
        firstTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
        firstTeam.trailingAnchor.constraint(equalTo: score.leadingAnchor, constant: -50),
        firstTeam.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        
        score.centerYAnchor.constraint(equalTo: centerYAnchor),
        score.centerXAnchor.constraint(equalTo: centerXAnchor),

        secondTeam.leadingAnchor.constraint(equalTo: score.trailingAnchor, constant: 50),
        secondTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
        secondTeam.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
