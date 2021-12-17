import Foundation
import UIKit

protocol PlotGmpModuleInput: AnyObject {
    func setMatchId(_ id: Int)
}

protocol PlotGmpModuleOutput: AnyObject {}

final class PlotGmpModulePresenter {
    weak var view: PlotGmpModuleViewInput? {
        didSet {
            requestData()
        }
    }

    private var gmpData: [GmpPresenterData] = []

    let output: PlotGmpModuleOutput
    private let networkService: MatchDetailService
    private var matchDetail: MatchDetail!
    private var matchId: Int

    required init(output: PlotGmpModuleOutput, networkService: MatchDetailService) {
        self.output = output
        self.networkService = networkService
        self.state = .none
        self.matchId = 6323862456
    }

    private var state: PlotGmpModulePresenterState {
        didSet {
            switch state {
            case .success(let matchDetail):
                convert(from: matchDetail)
                view?.update(state: .success)
            case .error(let error):
                view?.update(state: .error(error.localizedDescription))
            case .loading:
                view?.update(state: .loading)
            case .none:
                break
            }
        }
    }

    private func requestData() {
        state = .loading
        _ = networkService.requestMatchDetail(id: matchId) { [weak self] result in
            switch result {
            case .success(let matchDetail):
                self?.state = .success(matchDetail)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
    
    private func convert(from matchDetail: MatchDetail) {
        let players = matchDetail.players
        let arrayOfColors: [UIColor] = [.yellow,
                                        .red,
                                        .blue,
                                        .brown,
                                        .green,
                                        .cyan,
                                        .systemPink,
                                        .systemPurple,
                                        .black,
                                        .orange]
        
        for i in 0..<players.count {
            let shortGmpData = GmpPresenterData(heroId: players[i].heroId ?? 0,
                                                gmp: players[i].goldT ?? [], color: arrayOfColors[i])
            gmpData.append(shortGmpData)
        }
    }
}

// MARK: - PlotGmpModuleInput

extension PlotGmpModulePresenter: PlotGmpModuleInput {
    func setMatchId(_ id: Int) {
        matchId = id
        requestData()
    }
}

// MARK: - PlotGmpModuleViewOutput

extension PlotGmpModulePresenter: PlotGmpModuleViewOutput {
    func getScaledGoldT(arrays: [[Int]],
                        widthOfMinute: CGFloat,
                        height: CGFloat,
                        heightOfGmpView: CGFloat,
                        maxGold: CGFloat,
                        space: CGPoint) -> [[CGPoint]]
    {
        let multX = widthOfMinute
        let multY = height/maxGold
        var res = [[CGPoint]]()
        for array in arrays {
            var newArray = [CGPoint]()
            for i in 0..<array.count {
                let scaledPoint = CGPoint(x: CGFloat(i) * multX,
                                          y: heightOfGmpView - CGFloat(array[i]) * multY)
                newArray.append(scaledPoint.add(space))
            }
            res.append(newArray)
        }
        return res
    }
    
    func getPointsInGoldAxis(maxGold: CGFloat) -> [Int] {
        let maxMark = maxGold.round()
        print(maxMark)
        let multipliyer = maxMark/4
        var array = [Int]()
        for i in 0 ... 4 {
            array.append(i * multipliyer)
        }
        
        return array
    }
    
    func getScaledHorLeft(pointsInGoldAxis points: [Int],
                          height: CGFloat,
                          heightOfGmpView: CGFloat,
                          maxGold: CGFloat,
                          space: CGPoint) -> [CGPoint]
    {
        let multY = height/maxGold
        var res = [CGPoint]()
        for i in 0..<points.count {
            let scaledPoint = CGPoint(x: 0,
                                      y: heightOfGmpView - CGFloat(points[i]) * multY)
            res.append(scaledPoint.add(space))
        }

        return res
    }
    
    func getScaledHorRight(pointsInGoldAxis points: [Int],
                           height: CGFloat,
                           heightOfGmpView: CGFloat,
                           maxGold: CGFloat,
                           goldTCount: Int,
                           space: CGPoint,
                           widthOfMinute: CGFloat) -> [CGPoint]
    {
        let multY = height/maxGold
        let x = CGFloat(goldTCount - 1) * widthOfMinute
        var res = [CGPoint]()
        for i in 0..<points.count {
            let scaledPoint = CGPoint(x: x,
                                      y: heightOfGmpView - CGFloat(points[i]) * multY)
            res.append(scaledPoint.add(space))
        }

        return res
    }
    
    func getScaledVerBottom(goldTCount: Int,
                            widthOfMinute: CGFloat,
                            heightOfGmpView: CGFloat,
                            space: CGPoint) -> [CGPoint]
    {
        let y: CGFloat = heightOfGmpView
        var res = [CGPoint]()
        for i in 0..<goldTCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }
        
        return res
    }
    
    func getScaledVerTop(goldTCount: Int,
                         height: CGFloat,
                         heightOfGmpView: CGFloat,
                         space: CGPoint,
                         maxGold: CGFloat,
                         widthOfMinute: CGFloat,
                         pointsInGoldAxis points: [Int]) -> [CGPoint]
    {
        let multY = height/maxGold
        let y: CGFloat = heightOfGmpView - CGFloat(points.last ?? 0) * multY
        
        var res = [CGPoint]()
        for i in 0..<goldTCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }
        
        return res
    }
    
    func getPlotLines(form arrays: [[CGPoint]],
                      colors: [UIColor],
                      fillColor: UIColor?) -> [CAShapeLayer]
    {
        var lines = [CAShapeLayer]()
        
        for i in 0..<arrays.count {
            let arr = arrays[i]
            let line = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.move(to: arr.first ?? .zero)

            for point in arr {
                linePath.addLine(to: point)
            }

            line.path = linePath.cgPath
            line.strokeColor = colors[i].cgColor
            line.lineWidth = 2
            line.lineJoin = .round
            line.fillColor = fillColor?.cgColor

            lines.append(line)
        }
        
        return lines
    }
    
    func getVertGridLines(pointsVertBottom: [CGPoint],
                          pointsVertTop: [CGPoint],
                          fillColor: UIColor?) -> CAShapeLayer
    {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        
        for i in 0..<pointsVertBottom.count {
            linePath.move(to: pointsVertBottom[i])
            linePath.addLine(to: pointsVertTop[i])
        }

        line.path = linePath.cgPath
        line.strokeColor = UIColor(ciColor: .gray).cgColor
        line.lineWidth = 0.5
        line.lineJoin = .round
        line.fillColor = fillColor?.cgColor

        return line
    }
    
    func getHorGridLines(pointsHorLeft: [CGPoint],
                         pointsHorRight: [CGPoint],
                         fillColor: UIColor?) -> CAShapeLayer
    {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        
        for i in 0..<pointsHorLeft.count {
            linePath.move(to: pointsHorLeft[i])
            linePath.addLine(to: pointsHorRight[i])
        }

        line.path = linePath.cgPath
        line.strokeColor = UIColor(ciColor: .gray).cgColor
        line.lineWidth = 0.5
        line.lineJoin = .round
        line.fillColor = fillColor?.cgColor

        return line
    }
    
//    func getDataGoldT() -> [GmpPresenterData] {
//        return gmpData
//    }
    
    func getArrayOfGoldT() -> [[Int]] {
        var res = [[Int]]()
        for data in gmpData {
            res.append(data.gmp)
        }
        return res
    }
    
    func getArrayOfColors() -> [UIColor] {
        var res = [UIColor]()
        for data in gmpData {
            res.append(data.color)
        }
        return res
    }
    
    func getArrayOfHeroes() -> [String] {
        var res = [String]()
        for data in gmpData {
            res.append("ID: \(data.heroId)")
        }
        return res
    }
}


extension CGPoint {
    func add(_ space : CGPoint) -> CGPoint {
        CGPoint(x: self.x + space.x, y: self.y + space.y)
    }
}

extension CGFloat {
    func round() -> Int {
        let res = (Int(self) + 1000) / 1000 * 1000
        return res
    }
}
