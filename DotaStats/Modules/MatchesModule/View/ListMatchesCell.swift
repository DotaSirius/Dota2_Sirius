import UIKit

class ListMatchesCell: UITableViewCell {
    static let reuseIdentifier = "ListMatchesCell"
    
    lazy var firstTeam: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .center
        control.textColor = .green
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
    
    lazy var firstTeamScore: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        control.textAlignment = .center
        control.textColor = .green
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
    
    lazy var score: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        control.textAlignment = .center
        control.textColor = .green
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
    
    lazy var secondTeamScore: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        control.textAlignment = .center
        control.textColor = .green
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
    
    lazy var secondTeam: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .center
        control.textColor = .red
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
    
    lazy var duration: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        control.textAlignment = .center
        control.textColor = ColorPalette.mainText
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()

    func addView() {
        contentView.addSubview(duration)
        contentView.addSubview(firstTeam)
        contentView.addSubview(firstTeamScore)
        contentView.addSubview(secondTeamScore)
        contentView.addSubview(secondTeam)
        
        NSLayoutConstraint.activate([
            firstTeam.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            firstTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
            firstTeam.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -305),
            
            score.leadingAnchor.constraint(equalTo: firstTeam.trailingAnchor, constant: 20),
            score.centerYAnchor.constraint(equalTo: centerYAnchor),
            score.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200),
//            firstTeamScore.leadingAnchor.constraint(equalTo: firstTeam.trailingAnchor, constant: 10),
//            firstTeamScore.centerYAnchor.constraint(equalTo: centerYAnchor),
//            firstTeamScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -265),
//
//            secondTeamScore.leadingAnchor.constraint(equalTo: firstTeamScore.trailingAnchor, constant: 10),
//            secondTeamScore.centerYAnchor.constraint(equalTo: centerYAnchor),
//            secondTeamScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -230),
            
            secondTeam.leadingAnchor.constraint(equalTo: secondTeamScore.trailingAnchor, constant: 10),
            secondTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondTeam.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -110),
            
            duration.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 310),
            duration.centerYAnchor.constraint(equalTo: centerYAnchor),
            duration.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
