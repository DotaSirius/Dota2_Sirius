import UIKit


class ListMatchesCell: UITableViewCell {
    
    static let reuseIdentifier = "ListMatchesCell"
    
    lazy var firstTeam: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .right
        control.textColor = ColorPalette.win
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 5;
        return control
        
    }()
    
    lazy var secondTeam: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .left
        control.textColor = ColorPalette.lose
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3;
        return control
        
    }()
    
    lazy var score: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        control.textAlignment = .center
        control.textColor = ColorPalette.mainText
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 1
        return control
        
    }()
    
    func addView() {
        backgroundColor = ColorPalette.alternatеBackground

        contentView.addSubview(firstTeam)
        contentView.addSubview(secondTeam)
        contentView.addSubview(score)
        
        NSLayoutConstraint.activate([
        score.centerYAnchor.constraint(equalTo: centerYAnchor),
        score.centerXAnchor.constraint(equalTo: centerXAnchor),
        score.widthAnchor.constraint(equalToConstant: 50),
        
        firstTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
        firstTeam.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -50),
        firstTeam.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        
        secondTeam.centerYAnchor.constraint(equalTo: centerYAnchor),
        secondTeam.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 50),
        secondTeam.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
