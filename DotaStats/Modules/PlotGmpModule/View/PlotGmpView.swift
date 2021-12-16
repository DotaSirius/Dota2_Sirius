import UIKit

enum Constants : Int {
    case numberOfHorizontalLines = 4
    case minutesOnScreen = 16
}

final class PlotGmpView : UIView {
    
    func getGoldAxisPoints() -> [CGPoint] {
        let marksInGoldAxis = getPointsInGoldAxis(last: goldT.last)
        let pointsHorLeftGrid = getScaledHorLeft(pointsInGoldAxis: marksInGoldAxis,
                                                 height: availableHeightOfGrid,
                                                 maxGold: maxGold,
                                                 space: space)
        return pointsHorLeftGrid
    }
    
    func getGoldAxisMarks() -> [Int] {
        let marksInGoldAxis = getPointsInGoldAxis(last: goldT.last)
        return marksInGoldAxis
    }
    
    private var goldT : [Int]
    private var maxGold : CGFloat
    private var colorOfLine : UIColor
    private let space = CGPoint(x: 20, y: -20)
    
    private var availableHeightOfGraph : CGFloat
    private var availableHeightOfGrid : CGFloat
    private let widthOfMinute : CGFloat
    
    init(goldT : [Int], colorOfLine : UIColor, sizeOfScreen : CGSize) {
        self.goldT = goldT
        self.colorOfLine = colorOfLine
        
        widthOfMinute = (sizeOfScreen.width - space.x)/16
        maxGold = CGFloat(goldT.max() ?? 1)
            
        self.availableHeightOfGraph = 200 + 3 * space.y
        self.availableHeightOfGrid = 200 + 2 * space.y
        
        super.init(frame : CGRect(origin: CGPoint(x: 0, y: 0),
                                  size: CGSize(width: widthOfMinute * CGFloat(goldT.count),
                                               height: 220)))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let boundsSize = bounds.size
        
        //MARK: - Get scaled [CGPoint]
        let goldTCGPoints = getScaledGoldT(sizeOfView: boundsSize,
                                           array: goldT,
                                           widthOfMinute: widthOfMinute,
                                           height: availableHeightOfGraph,
                                           maxGold: maxGold,
                                           space: space)
        
        let marksInGoldAxis = getPointsInGoldAxis(last: goldT.last)
        
        let pointsHorLeftGrid = getScaledHorLeft(pointsInGoldAxis: marksInGoldAxis,
                                                 height: availableHeightOfGrid,
                                                 maxGold: maxGold,
                                                 space: space)
        
        let pointsHorRightGrid = getScaledHorRight(pointsInGoldAxis: marksInGoldAxis,
                                                   height: availableHeightOfGrid,
                                                   maxGold: maxGold,
                                                   goldTCount: goldT.count,
                                                   space: space,
                                                   widthOfMinute: widthOfMinute)
        
        let pointdVerBottomGrid = getScaledVerBottom(goldTCount: goldT.count,
                                                     widthOfMinute: widthOfMinute)
        
        let pointdVerTopGrid = getScaledVerTop(goldTCount: goldT.count,
                                               height: availableHeightOfGrid,
                                               maxGold: maxGold,
                                               widthOfMinute: widthOfMinute,
                                               pointsInGoldAxis: marksInGoldAxis)
        
        //MARK: - Get lines from [CGPoints]
        let gridHorLines = createHorGridLines(pointsHorLeft: pointsHorLeftGrid,
                                              pointsHorRight: pointsHorRightGrid)
        
        let gridVerLines = createVertGridLines(pointsVertBottom: pointdVerBottomGrid,
                                               pointsVertTop: pointdVerTopGrid)
        
        let plotLine = createPlotLine(form: goldTCGPoints, color: colorOfLine)

        
        layer.backgroundColor = UIColor(ciColor: .white).cgColor
        layer.addSublayer(plotLine)
        layer.addSublayer(gridVerLines)
        layer.addSublayer(gridHorLines)
        
    }

    private func getScaledGoldT(sizeOfView : CGSize,
                                array: [Int],
                                widthOfMinute : CGFloat,
                                height : CGFloat,
                                maxGold : CGFloat,
                                space : CGPoint) -> [CGPoint] {
        let multX = widthOfMinute
        let multY = height/maxGold
        var res = [CGPoint]()
        for i in 0 ..< array.count {
            let scaledPoint = CGPoint(x: CGFloat(i)*multX,
                                      y: frame.maxY - CGFloat(array[i])*multY)
            res.append(scaledPoint.add(space))
        }

        return res
    }
    
    private func getPointsInGoldAxis(last : Int?) -> [Int] {
        guard let last = last else { return [] }
        let maxMark = last.round()
        print(maxMark)
        let multipliyer = maxMark / 4
        var array = [Int]()
        for i in 0...4 {
            array.append(i * multipliyer)
        }
        
        return array
    }
    
    private func getScaledHorLeft(pointsInGoldAxis points : [Int],
                                  height : CGFloat,
                                  maxGold : CGFloat,
                                  space : CGPoint) -> [CGPoint] {
        let multY = height/maxGold
        var res = [CGPoint]()
        for i in 0 ..< points.count {
            let scaledPoint = CGPoint(x: 0,
                                      y: frame.maxY - CGFloat(points[i])*multY)//TODO: frame.maxY
            res.append(scaledPoint.add(space))
        }

        return res
    }
    
    private func getScaledHorRight(pointsInGoldAxis points : [Int],
                                   height : CGFloat,
                                   maxGold : CGFloat,
                                   goldTCount : Int,
                                   space : CGPoint,
                                   widthOfMinute : CGFloat) -> [CGPoint] {
        let multY = height/maxGold
        let x = CGFloat(goldTCount - 1) * widthOfMinute
        var res = [CGPoint]()
        for i in 0 ..< points.count {
            let scaledPoint = CGPoint(x: x,
                                      y: frame.maxY - CGFloat(points[i])*multY)
            res.append(scaledPoint.add(space))
        }

        return res
    }

    private func getScaledVerBottom(goldTCount : Int,
                                    widthOfMinute : CGFloat) -> [CGPoint] {
        let y : CGFloat = frame.maxY
        var res = [CGPoint]()
        for i in 0..<goldTCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }
        
        return res
    }
    
    private func getScaledVerTop(goldTCount : Int,
                                 height : CGFloat,
                                 maxGold : CGFloat,
                                 widthOfMinute : CGFloat,
                                 pointsInGoldAxis points : [Int]) -> [CGPoint] {
        let multY = height/maxGold
        let y : CGFloat = frame.maxY - (CGFloat(points.last ?? 0))*multY
        
        var res = [CGPoint]()
        for i in 0..<goldTCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }
        
        return res
    }
    
    private func createPlotLine(form arr: [CGPoint], color: UIColor) -> CAShapeLayer {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: arr.first ?? .zero)

        for point in arr {
            linePath.addLine(to: point)
        }

        line.path = linePath.cgPath
        line.strokeColor = color.cgColor
        line.lineWidth = 2
        line.lineJoin = .round
        line.fillColor = self.backgroundColor?.cgColor

        return line
    }
    
    private func createVertGridLines(pointsVertBottom : [CGPoint],
                                     pointsVertTop : [CGPoint]) -> CAShapeLayer  {
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
        line.fillColor = self.backgroundColor?.cgColor

        return line
    }
    
    private func createHorGridLines(pointsHorLeft : [CGPoint],
                                    pointsHorRight : [CGPoint]) -> CAShapeLayer  {
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
        line.fillColor = self.backgroundColor?.cgColor

        return line
    }
}


extension CGPoint {
    func add(_ space : CGPoint) -> CGPoint {
        CGPoint(x: self.x + space.x, y: self.y + space.y)
    }
}

extension Int {
    func round() -> Int {
        let res = (self + 1000) / 1000 * 1000
        return res
    }
}
