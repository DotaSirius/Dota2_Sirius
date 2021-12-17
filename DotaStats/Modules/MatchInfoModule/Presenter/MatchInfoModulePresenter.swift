import UIKit

protocol MatchInfoModuleInput: AnyObject {
    func setMatchId(_ id: Int)
}

protocol MatchInfoModuleOutput: AnyObject {}

protocol MatchInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection(_ section: Int) -> Int
    func getCellData(for row: Int) -> MatchTableViewCellData
    func getArrayOfGoldT() -> [[Int]]
    func getArrayOfColors() -> [UIColor]
    func getArrayOfHeroes() -> [String]
    func getScaledGoldT(arrays: [[Int]],
                        widthOfMinute: CGFloat,
                        height: CGFloat,
                        heightOfGmpView: CGFloat,
                        maxGold: CGFloat,
                        space: CGPoint) -> [[CGPoint]]
    func getPointsInGoldAxis(maxGold: CGFloat) -> [Int]
    func getScaledHorLeft(pointsInGoldAxis points: [Int],
                          height: CGFloat,
                          heightOfGmpView: CGFloat,
                          maxGold: CGFloat,
                          space: CGPoint) -> [CGPoint]
    func getScaledHorRight(pointsInGoldAxis points: [Int],
                           height: CGFloat,
                           heightOfGmpView: CGFloat,
                           maxGold: CGFloat,
                           goldTCount: Int,
                           space: CGPoint,
                           widthOfMinute: CGFloat) -> [CGPoint]
    func getScaledVerBottom(goldTCount: Int,
                            widthOfMinute: CGFloat,
                            heightOfGmpView: CGFloat,
                            space: CGPoint) -> [CGPoint]
    func getScaledVerTop(goldTCount: Int,
                         height: CGFloat,
                         heightOfGmpView: CGFloat,
                         space: CGPoint,
                         maxGold: CGFloat,
                         widthOfMinute: CGFloat,
                         pointsInGoldAxis points: [Int]) -> [CGPoint]
    func getPlotLines(form arrays: [[CGPoint]],
                      colors: [UIColor],
                      fillColor: UIColor?) -> [CAShapeLayer]
    func getVertGridLines(pointsVertBottom: [CGPoint],
                          pointsVertTop: [CGPoint],
                          fillColor: UIColor?) -> CAShapeLayer
    func getHorGridLines(pointsHorLeft: [CGPoint],
                         pointsHorRight: [CGPoint],
                         fillColor: UIColor?) -> CAShapeLayer
}

final class MatchInfoModulePresenter {
    weak var view: MatchInfoModuleViewInput?

    let output: MatchInfoModuleOutput
    private let converter: MatchInfoConverter
    private var convertedData: [MatchTableViewCellType] = []
    private let networkService: MatchDetailService
    private var rawMatchInfo: MatchDetail!
    private var convertedMatchInfo: [MatchTableViewCellType]?
    private var matchId: Int
    private var gmpData: [GmpPresenterData] = []

    private var state: MatchesInfoModuleViewState {
        didSet {
            switch state {
            case .success:
                self.convertedData = [
                    MatchTableViewCellType.mainMatchInfo(
                        converter.mainMatchInfo(from: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.additionalMatchInfo(
                        converter.additionalMatchInfo(from: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.teamMatchInfo(
                        converter.radiantMatchInfo(from: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.matchPlayerHeaderInfo
                ]
                for index in 0..<5 {
                    self.convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(from: self.rawMatchInfo, playerNumber: index)
                        )
                    )
                }
                self.convertedData.append(
                    MatchTableViewCellType.teamMatchInfo(
                        converter.direMatchInfo(from: self.rawMatchInfo)
                    )
                )
                for index in 5..<10 {
                    self.convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(from: self.rawMatchInfo, playerNumber: index)
                        )
                    )
                }
                view?.update(state: .success)
            case .error:
                view?.update(state: .error)
            case .loading:
                view?.update(state: .loading)
            }
        }
    }

    required init(converter: MatchInfoConverter, output: MatchInfoModuleOutput, networkService: MatchDetailService) {
        self.converter = converter
        self.output = output
        self.networkService = networkService
        self.state = .loading
        self.matchId = 1
    }

    private func requestData() {
        state = .loading
        networkService.requestMatchDetail(id: matchId) { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let rawMatchInfo):
                self.rawMatchInfo = rawMatchInfo
                self.state = .success

            case .failure:
                self.state = .error
            }
        }
    }
}

// MARK: - MatchInfoModuleInput

extension MatchInfoModulePresenter: MatchInfoModuleInput {
    func setMatchId(_ id: Int) {
        matchId = id
        requestData()
    }
}

// MARK: - MatchInfoModuleViewOutput

extension MatchInfoModulePresenter: MatchInfoModuleViewOutput {
    func getSectionCount() -> Int {
        return 1
    }

    func getRowsCountInSection(_ section: Int) -> Int {
        return convertedData.count
    }

    func getCellData(for row: Int) -> MatchTableViewCellData {
        return MatchTableViewCellData(type: convertedData[row])
    }

    func getScaledGoldT(arrays: [[Int]],
                        widthOfMinute: CGFloat,
                        height: CGFloat,
                        heightOfGmpView: CGFloat,
                        maxGold: CGFloat,
                        space: CGPoint) -> [[CGPoint]] {
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
                          space: CGPoint) -> [CGPoint] {
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
                           widthOfMinute: CGFloat) -> [CGPoint] {
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
                            space: CGPoint) -> [CGPoint] {
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
                         pointsInGoldAxis points: [Int]) -> [CGPoint] {
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
                      fillColor: UIColor?) -> [CAShapeLayer] {
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
                          fillColor: UIColor?) -> CAShapeLayer {
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
                         fillColor: UIColor?) -> CAShapeLayer {
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
