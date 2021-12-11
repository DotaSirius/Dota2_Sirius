//
//  MainMatchInfo.swift
//  DotaStats
//
//  Created by Костина Вероника  on 10.12.2021.
//

import UIKit

class MainMatchInfoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MainMatchInfoTableViewCell"
    private let timeScoreStackView = UIStackView()
    private let mainMatchInfoStackView = UIStackView()
    private let colorPalette = ColorPalette()
    
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
        contentView.backgroundColor = colorPalette.mainBackground
        [mainMatchInfoStackView].forEach{contentView.addSubview($0)}
        
        winnersLabel.textColor = colorPalette.win
        winnersLabel.font = UIFont.systemFont(ofSize: 30) //изменить шрифт
        
        gameTimeLabel.textColor = colorPalette.mainText
        gameTimeLabel.font = UIFont.systemFont(ofSize: 20) //изменить шрифт
        
        firstTeamScoreLabel.textColor = colorPalette.win
        firstTeamScoreLabel.font = UIFont.systemFont(ofSize: 30) //изменить шрифт
        
        secondTeamScoreLabel.textColor = colorPalette.lose
        secondTeamScoreLabel.font = UIFont.systemFont(ofSize: 30) //изменить шрифт
        
        matchEndTimeLabel.text = "ENDED 14 HOURS AGO" //данные придут из сети
        matchEndTimeLabel.textColor = colorPalette.subtitle
        matchEndTimeLabel.font = UIFont.systemFont(ofSize: 15) //изменить шрифт
        
        createStackView(stackView: timeScoreStackView, axis: .horizontal, spacing: 24)
        [firstTeamScoreLabel, gameTimeLabel, secondTeamScoreLabel].forEach{timeScoreStackView.addArrangedSubview($0)}
        
        createStackView(stackView: mainMatchInfoStackView, axis: .vertical, spacing: 8)
        [winnersLabel, timeScoreStackView, matchEndTimeLabel].forEach{mainMatchInfoStackView.addArrangedSubview($0)}
        
}
    
    func createStackView(stackView:UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }
    
     func setUpConstraints() {
        [mainMatchInfoStackView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
         mainMatchInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
         mainMatchInfoStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
         mainMatchInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension MainMatchInfoTableViewCell:  DetailedMatchInfoCellConfigurable {
//    func configure(with data: MatchTableViewCellType) {
//        winnersLabel.text = "Radiant Victory" // из сети
//        gameTimeLabel.text = "24:10" //данные придут из сети
//        firstTeamScoreLabel.text = "29" //данные придут из сети
//        secondTeamScoreLabel.text = "5" //данные придут из сети
//    }
    
        func configure(with data: String) {
            winnersLabel.text = "Radiant Victory" // из сети
            gameTimeLabel.text = "24:10" //данные придут из сети
            firstTeamScoreLabel.text = "29" //данные придут из сети
            secondTeamScoreLabel.text = "5" //данные придут из сети
        }
}
