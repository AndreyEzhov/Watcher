//
//  ChartViewController.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: BaseViewController<ChartPresentable>, ChartDisplayable {
    
    // MARK: - Properties
    
    @IBOutlet private weak var candleChartView: CandleStickChartView!
    
    @IBOutlet private weak var chartSwitch: UISwitch!
    
    @IBOutlet private weak var customChart: CandleChart!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchCharts()
        setupChart()
        presenter?.openSocket(unit: Consts.Positions.BTCUSD)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition:nil) { (context) in
            if !self.chartSwitch.isOn {
                self.customChart.redraw()
            }
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    deinit {
        presenter?.closeSocket()
    }
    
    // MARK: - Private Functions
    
    private func setupChart() {
        candleChartView.pinchZoomEnabled = true
    }
    
    private func switchCharts() {
        candleChartView.isHidden = !chartSwitch.isOn
        customChart.isHidden = chartSwitch.isOn
    }
    
    private func drawInChart(candels: [CandleModel]) {
        let dataEntries: [CandleChartDataEntry] = candels.map {
            CandleChartDataEntry(x: Double($0.x),
                                 shadowH: $0.shadowH,
                                 shadowL: $0.shadowL,
                                 open: $0.open,
                                 close: $0.close)
        }
        
        let chartDataSet = CandleChartDataSet(values: dataEntries, label: Consts.Positions.BTCUSD)
        let chartData = CandleChartData(dataSets: [chartDataSet])
        
        chartDataSet.increasingFilled = true
        
        chartDataSet.shadowColor = UIColor.darkGray
        chartDataSet.shadowWidth = 5
        chartDataSet.decreasingColor = UIColor.red
        chartDataSet.decreasingFilled = true
        chartDataSet.increasingColor = UIColor.green
        chartDataSet.increasingFilled = true
        chartDataSet.neutralColor = UIColor.blue
        
        candleChartView.data = chartData
    }
    
    private func drawInCustomChart(candels: [CandleModel]) {
        let dataPoints: [CandleChartDataPoint] = candels.map {
            CandleChartDataPoint(x: $0.x,
                                 shadowH: $0.shadowH,
                                 shadowL: $0.shadowL,
                                 open: $0.open,
                                 close: $0.close)
        }
        
        let chartDataSource = CandleChartDataSource(with: dataPoints)
        customChart.dataSource = chartDataSource
    }
    
    // MARK: - Actions
    
    @IBAction func switchTouch(_ sender: UISwitch) {
        switchCharts()
        presenter?.loadData()
    }
    
    // MARK: - ChartDisplayable
    
    func draw(candels: [CandleModel]) {
        if chartSwitch.isOn {
            drawInChart(candels: candels)
            return
        }
        drawInCustomChart(candels: candels)
    }
}
