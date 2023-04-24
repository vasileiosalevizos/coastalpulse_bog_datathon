//
//  BarChartView.swift
//  CoastalPulse
//
//  Created by Δήμητρα Μαλλιαρου on 23/4/23.
//

import UIKit

class BarChartView: UIView {

    private let mainLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()
    let space: CGFloat = 20.0
    let barHeight: CGFloat = 30.0
    let contentSpace: CGFloat = 58.0

    
    var dataEntries: [BarEntry] = [] {
    didSet {
       mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
       scrollView.contentSize = CGSize(width: frame.size.width, height:
       barHeight + space * CGFloat(dataEntries.count) + contentSpace)
       mainLayer.frame = CGRect(x: 0, y: 0, width:
       scrollView.contentSize.width, height:
       scrollView.contentSize.height)
       for i in 0..<dataEntries.count {
          showEntry(index: i, entry: dataEntries[i])
       }
     }
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       setupView()
    }
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
       scrollView.layer.addSublayer(mainLayer)
       addSubview(scrollView)
    }
    override func layoutSubviews() {
       scrollView.frame = CGRect(x: 0, y: 0, width: frame.size.width,
       height: frame.size.height)
    }
    
    private func showEntry(index: Int, entry: BarEntry) {
       let xPos: CGFloat = translateWidthValueToXPosition(value:
       Float(entry.score) / Float(100.0))
       let yPos: CGFloat = space + CGFloat(index) * (barHeight + space)
    drawBar(xPos: xPos, yPos: yPos)
       drawTextValue(xPos: xPos + 155.0, yPos: yPos + 4.0, textValue: "\(entry.score)")
       drawTitle(xPos: 16.0, yPos: yPos + 12.0, width: 50.0, height:
       40.0, title: entry.title)
    }
    
    private func drawBar(xPos: CGFloat, yPos: CGFloat) {
       let barLayer = CALayer()
       barLayer.frame = CGRect(x: 144.0, y: yPos, width: xPos, height: 20.0)
       barLayer.backgroundColor = UIColor.blue.cgColor
       mainLayer.addSublayer(barLayer)
    }
    
    private func drawTextValue(xPos: CGFloat, yPos: CGFloat, textValue: String) {
       let textLayer = CATextLayer()
       textLayer.frame = CGRect(x: xPos, y: yPos, width: 25, height: 80.0)
       textLayer.foregroundColor = UIColor.black.cgColor
       textLayer.backgroundColor = UIColor.clear.cgColor
       textLayer.alignmentMode = CATextLayerAlignmentMode.center
       textLayer.contentsScale = UIScreen.main.scale
       textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 14.0).fontName as CFString, 0, nil)
       textLayer.fontSize = 14
       textLayer.string = textValue
       mainLayer.addSublayer(textLayer)
    }
    
    private func drawTitle(xPos: CGFloat, yPos: CGFloat, width: CGFloat, height: CGFloat = 22, title: String) {
       let textLayer = CATextLayer()
       textLayer.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
       textLayer.foregroundColor = UIColor.black.cgColor
       textLayer.backgroundColor = UIColor.clear.cgColor
       textLayer.alignmentMode = CATextLayerAlignmentMode.left
       textLayer.contentsScale = UIScreen.main.scale
       textLayer.font = CTFontCreateWithName(UIFont.boldSystemFont(ofSize: 14.0).fontName as CFString, 0, nil)
       textLayer.fontSize = 14
       textLayer.string = title
       mainLayer.addSublayer(textLayer)
    }
    
    private func translateWidthValueToXPosition(value: Float) -> CGFloat
    {
       let width = CGFloat(value) * (mainLayer.frame.width - space)
       return abs(width)
    }
}
