//
//  CandleChart.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit

class CandleChart: UIView {
    
    // MARK: - Properties
    
    private var lastPanPoint = CGPoint.zero
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var valueStringAttributes: [NSAttributedStringKey : Any]? {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .right
        return [NSAttributedStringKey.paragraphStyle: paragraph,
                NSAttributedStringKey.foregroundColor: UIColor.blue]
    }
    
    private var itemWidth: CGFloat {
        return pointWidth + ticksSpice
    }
    
    private var chartInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    
    private var pointWidth: CGFloat = 20.0
    
    private var shadowWidth: CGFloat = 2.0
    
    private var ticksSpice: CGFloat = 1.0
    
    private var crossHairWidth: CGFloat = 1.0
    
    private var startX: CGFloat = 0
    
    private var minX: CGFloat = 0
    
    private var maxX: CGFloat = 0
    
    private var pinToLastTick = true
    
    var dataSource: CandleChartDataSource? {
        didSet {
            minX = CGFloat(dataSource?.points.first?.x ?? 0)
            maxX = CGFloat(dataSource?.points.last?.x ?? 0)
            if pinToLastTick {
                startX = maxX * itemWidth
                recalculateStartX()
            }
            setNeedsDisplay()
        }
    }
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - Private Functions
    
    private func initialize() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            lastPanPoint = .zero
        } else if recognizer.state == .changed {
            let translation = recognizer.translation(in: self)
            let translationX = translation.x - lastPanPoint.x
            lastPanPoint = recognizer.translation(in: self)
            startX -= translationX
            pinToLastTick = startX > maxX * pointWidth - frame.width / 2.0
            recalculateStartX()
            setNeedsDisplay()
        }
    }
    
    private func recalculateStartX() {
        startX = max(minX, startX)
        startX = min(startX, maxX * pointWidth - frame.width / 2.0)
        startX = max(startX, 0)
    }
    
    // MARK: - Functions
    
    func redraw() {
        if pinToLastTick {
            startX = maxX * pointWidth
        }
        recalculateStartX()
        setNeedsDisplay()
    }
    
    // MARK: - View lifecycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let dataSource = dataSource else {
            return
        }
        
        let heightForDivision = (rect.height - chartInsets.top - chartInsets.bottom) / CGFloat((dataSource.maxY - dataSource.minY))
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(shadowWidth)
        
        // Candles
        
        dataSource.points.forEach({
            var color: UIColor!
            var h = CGFloat($0.close - $0.open)
            var y: Double!
            
            if h < 0 {
                h = -h
                y = $0.open
                color = dataSource.decreasingColor
            } else {
                y = $0.close
                color = dataSource.increasingColor
            }
            
            context?.setStrokeColor(dataSource.shadowColor.cgColor)
            
            context?.move(to: CGPoint(x: (CGFloat($0.x) + 0.5) * itemWidth - startX,
                                      y: chartInsets.bottom + CGFloat(dataSource.maxY - $0.high) * heightForDivision))
            context?.addLine(to: CGPoint(x: (CGFloat($0.x) + 0.5) * itemWidth - startX,
                                         y: chartInsets.bottom + CGFloat(dataSource.maxY - $0.low) * heightForDivision))
            context?.strokePath()
            
            let rect = CGRect(x: CGFloat($0.x) * itemWidth - startX,
                              y: chartInsets.bottom + CGFloat(dataSource.maxY - y) * heightForDivision,
                              width: pointWidth,
                              height: h * heightForDivision)
            context?.addRect(rect)
            context?.setFillColor(color.cgColor)
            context?.fillPath()
        })
        
        // Crosshair
        
        guard let lastCandlet = dataSource.points.last else {
            return
        }
        
        let crosshairY = chartInsets.bottom + CGFloat(dataSource.maxY - lastCandlet.close) * heightForDivision
        context?.setLineWidth(crossHairWidth)
        context?.move(to: CGPoint(x: 0,
                                  y: crosshairY))
        context?.addLine(to: CGPoint(x: rect.width,
                                     y: crosshairY))
        context?.strokePath()
        
        // Value string
        let stringValue = lastCandlet.close.toString(precision: dataSource.precision) as NSString
        let valueRect = CGRect(x: 0,
                               y: crosshairY - 15,
                               width: rect.width,
                               height: 15)
        stringValue.draw(in: valueRect, withAttributes: valueStringAttributes)
    }
}
