import UIKit

final class PlotGmpView : UIView {
    
    private var plotLines : [CAShapeLayer]
    private var gridVerLines : CAShapeLayer
    private var gridHorLines : CAShapeLayer
    
    
    init(plotLines : [CAShapeLayer],
         gridVerLines : CAShapeLayer,
         gridHorLines : CAShapeLayer,
         width : CGFloat,
         height : CGFloat) {
        
        self.plotLines = plotLines
        self.gridHorLines = gridHorLines
        self.gridVerLines = gridVerLines
        
        super.init(frame: CGRect(origin: .zero,
                                 size: CGSize(width: width,
                                              height: height)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.backgroundColor = UIColor(ciColor: .white).cgColor
        for line in plotLines {
            layer.addSublayer(line)
        }
        layer.addSublayer(gridVerLines)
        layer.addSublayer(gridHorLines)
        
    }
}



















//    private var goldT : [[Int]]
//    private var maxGold : CGFloat
//    private var colorsOfLines : [UIColor]
//    private let space = CGPoint(x: 20, y: -20)
//
//    private var availableHeightOfGraph : CGFloat
//    private var availableHeightOfGrid : CGFloat
//    private let widthOfMinute : CGFloat

//    init(goldT : [[Int]], colorOfLine : [UIColor], sizeOfScreen : CGSize) {
//        self.goldT = goldT
//        self.colorsOfLines = colorOfLine
//
//        widthOfMinute = (sizeOfScreen.width - space.x)/16
//
//        maxGold = 1
//        for gold in goldT {
//            maxGold = max(maxGold, CGFloat(gold.max() ?? 1))
//        }
//
//        self.availableHeightOfGraph = 200 + 3 * space.y
//        self.availableHeightOfGrid = 200 + 2 * space.y
//
//        super.init(frame : CGRect(origin: CGPoint(x: 0, y: 0),
//                                  size: CGSize(width: widthOfMinute * CGFloat(goldT[0].count),
//                                               height: 220)))
//    }



//draw

//        let heightOfGmpView = frame.maxY
//        let fillColorOfLines = backgroundColor
//
//        //MARK: - Get scaled [CGPoint]
//        let goldTCGPoints = getScaledGoldT(arrays: goldT,
//                                           widthOfMinute: widthOfMinute,
//                                           height: availableHeightOfGraph,
//                                           heightOfGmpView: heightOfGmpView,
//                                           maxGold: maxGold,
//                                           space: space)
//
//        let marksInGoldAxis = getPointsInGoldAxis(maxGold: maxGold)
//
//        let pointsHorLeftGrid = getScaledHorLeft(pointsInGoldAxis: marksInGoldAxis,
//                                                 height: availableHeightOfGrid,
//                                                 heightOfGmpView: heightOfGmpView,
//                                                 maxGold: maxGold,
//                                                 space: space)
//
//        let pointsHorRightGrid = getScaledHorRight(pointsInGoldAxis: marksInGoldAxis,
//                                                   height: availableHeightOfGrid,
//                                                   heightOfGmpView: heightOfGmpView,
//                                                   maxGold: maxGold,
//                                                   goldTCount: goldT[0].count,
//                                                   space: space,
//                                                   widthOfMinute: widthOfMinute)
//
//        let pointdVerBottomGrid = getScaledVerBottom(goldTCount: goldT[0].count,
//                                                     widthOfMinute: widthOfMinute,
//                                                     heightOfGmpView: heightOfGmpView,
//                                                     space: space)
//
//        let pointdVerTopGrid = getScaledVerTop(goldTCount: goldT[0].count,
//                                               height: availableHeightOfGrid,
//                                               heightOfGmpView: heightOfGmpView,
//                                               space: space,
//                                               maxGold: maxGold,
//                                               widthOfMinute: widthOfMinute,
//                                               pointsInGoldAxis: marksInGoldAxis)
//
//        //MARK: - Get lines from [CGPoints]
//        let gridHorLines = createHorGridLines(pointsHorLeft: pointsHorLeftGrid,
//                                              pointsHorRight: pointsHorRightGrid,
//                                              fillColor: fillColorOfLines)
//
//        let gridVerLines = createVertGridLines(pointsVertBottom: pointdVerBottomGrid,
//                                               pointsVertTop: pointdVerTopGrid,
//                                               fillColor: fillColorOfLines)
//
//        let plotLines = createPlotLines(form: goldTCGPoints, colors: colorsOfLines,
//                                        fillColor: fillColorOfLines)
//
//




//    private func getScaledGoldT(arrays: [[Int]],
//                                widthOfMinute : CGFloat,
//                                height : CGFloat,
//                                heightOfGmpView : CGFloat,
//                                maxGold : CGFloat,
//                                space : CGPoint) -> [[CGPoint]] {
//
//        let multX = widthOfMinute
//        let multY = height/maxGold
//        var res = [[CGPoint]]()
//        for array in arrays {
//            var newArray = [CGPoint]()
//            for i in 0 ..< array.count {
//                let scaledPoint = CGPoint(x: CGFloat(i)*multX,
//                                          y: heightOfGmpView - CGFloat(array[i])*multY)
//                newArray.append(scaledPoint.add(space))
//            }
//            res.append(newArray)
//        }
//        return res
//    }
//
//    private func getPointsInGoldAxis(maxGold : CGFloat) -> [Int] {
//        let maxMark = maxGold.round()
//        print(maxMark)
//        let multipliyer = maxMark / 4
//        var array = [Int]()
//        for i in 0...4 {
//            array.append(i * multipliyer)
//        }
//
//        return array
//    }
//
//    private func getScaledHorLeft(pointsInGoldAxis points : [Int],
//                                  height : CGFloat,
//                                  heightOfGmpView : CGFloat,
//                                  maxGold : CGFloat,
//                                  space : CGPoint) -> [CGPoint] {
//        let multY = height/maxGold
//        var res = [CGPoint]()
//        for i in 0 ..< points.count {
//            let scaledPoint = CGPoint(x: 0,
//                                      y: heightOfGmpView - CGFloat(points[i])*multY)
//            res.append(scaledPoint.add(space))
//        }
//
//        return res
//    }
//
//    private func getScaledHorRight(pointsInGoldAxis points : [Int],
//                                   height : CGFloat,
//                                   heightOfGmpView : CGFloat,
//                                   maxGold : CGFloat,
//                                   goldTCount : Int,
//                                   space : CGPoint,
//                                   widthOfMinute : CGFloat) -> [CGPoint] {
//        let multY = height/maxGold
//        let x = CGFloat(goldTCount - 1) * widthOfMinute
//        var res = [CGPoint]()
//        for i in 0 ..< points.count {
//            let scaledPoint = CGPoint(x: x,
//                                      y: heightOfGmpView - CGFloat(points[i])*multY)
//            res.append(scaledPoint.add(space))
//        }
//
//        return res
//    }
//
//    private func getScaledVerBottom(goldTCount : Int,
//                                widthOfMinute : CGFloat,
//                                heightOfGmpView : CGFloat,
//                                space : CGPoint) -> [CGPoint] {
//            let y : CGFloat = heightOfGmpView
//            var res = [CGPoint]()
//            for i in 0..<goldTCount where i % 2 == 0 {
//                let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
//                                          y: y)
//                res.append(scaledPoint.add(space))
//            }
//
//            return res
//        }
//
//    private func getScaledVerTop(goldTCount : Int,
//                                 height : CGFloat,
//                                 heightOfGmpView : CGFloat,
//                                 space : CGPoint,
//                                 maxGold : CGFloat,
//                                 widthOfMinute : CGFloat,
//                                 pointsInGoldAxis points : [Int]) -> [CGPoint] {
//        let multY = height/maxGold
//        let y : CGFloat = heightOfGmpView - (CGFloat(points.last ?? 0))*multY
//
//        var res = [CGPoint]()
//        for i in 0..<goldTCount where i % 2 == 0 {
//            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
//                                      y: y)
//            res.append(scaledPoint.add(space))
//        }
//
//        return res
//    }
//
//    private func createPlotLines(form arrays: [[CGPoint]],
//                                 colors: [UIColor],
//                                 fillColor : UIColor?) -> [CAShapeLayer] {
//
//        var lines = [CAShapeLayer]()
//
//        for i in 0..<arrays.count {
//            let arr = arrays[i]
//            let line = CAShapeLayer()
//            let linePath = UIBezierPath()
//            linePath.move(to: arr.first ?? .zero)
//
//            for point in arr {
//                linePath.addLine(to: point)
//            }
//
//            line.path = linePath.cgPath
//            line.strokeColor = colors[i].cgColor
//            line.lineWidth = 2
//            line.lineJoin = .round
//            line.fillColor = fillColor?.cgColor
//
//            lines.append(line)
//        }
//
//        return lines
//    }
//
//    private func createVertGridLines(pointsVertBottom : [CGPoint],
//                                     pointsVertTop : [CGPoint],
//                                     fillColor : UIColor?) -> CAShapeLayer  {
//        let line = CAShapeLayer()
//        let linePath = UIBezierPath()
//
//        for i in 0..<pointsVertBottom.count {
//            linePath.move(to: pointsVertBottom[i])
//            linePath.addLine(to: pointsVertTop[i])
//        }
//
//        line.path = linePath.cgPath
//        line.strokeColor = UIColor(ciColor: .gray).cgColor
//        line.lineWidth = 0.5
//        line.lineJoin = .round
//        line.fillColor = fillColor?.cgColor
//
//        return line
//    }
//
//    private func createHorGridLines(pointsHorLeft : [CGPoint],
//                                    pointsHorRight : [CGPoint],
//                                    fillColor : UIColor?) -> CAShapeLayer  {
//        let line = CAShapeLayer()
//        let linePath = UIBezierPath()
//
//        for i in 0..<pointsHorLeft.count {
//            linePath.move(to: pointsHorLeft[i])
//            linePath.addLine(to: pointsHorRight[i])
//        }
//
//        line.path = linePath.cgPath
//        line.strokeColor = UIColor(ciColor: .gray).cgColor
//        line.lineWidth = 0.5
//        line.lineJoin = .round
//        line.fillColor = fillColor?.cgColor
//
//        return line
//    }
