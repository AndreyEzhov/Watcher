//
//  ChartPresenter.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit
import SocketRocket

protocol ChartDisplayable: View {
    func draw(candels: [CandleModel])
}

protocol ChartPresentable: Presenter {
    func openSocket(unit: String?)
    func closeSocket()
    func loadData()
}

class ChartPresenter: NSObject, ChartPresentable, SRWebSocketDelegate {
    
    // MARK: - Properties
    
    private let candleManager = CandleManager()
    
    private var socket: SRWebSocket?
    
    private var currentUnit: String?
    
    private weak var timer: Timer?
    
    typealias T = ChartDisplayable
    
    weak var view: View?
    
    // MARK: - Private Functions
    
    private func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 5,
                                     target: self,
                                     selector: #selector(reopenSocket),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func reopenSocket() {
        openSocket(unit: currentUnit)
    }
    
    // MARK: - ChartPresentable
    
    func openSocket(unit: String?) {
        guard let unit = unit else {
            return
        }
        closeSocket()
        currentUnit = unit
        socket = SRWebSocket(url: URL(string: Consts.Socket.url))
        socket?.setDelegateOperationQueue(OperationQueue())
        socket?.delegate = self
        socket?.open()
    }
    
    func closeSocket() {
        guard let currentUnit = currentUnit else {
            return
        }
        socket?.send(Consts.Socket.unsubscribe(currentUnit).asComand)
        socket?.close()
    }
    
    func loadData() {
        contentView().draw(candels: candleManager.candles)
    }
    
    // MARK: - SRWebSocketDelegate
    
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        guard let message = message as? String,
            let socketResponse = JsonApiUtils.object(of: SocketResponse.self, string: message),
            let currentUnit = currentUnit,
            let tick = socketResponse.ticks[currentUnit]
            else {
                return
        }
        candleManager.add(tick: tick)
        onMain {
            self.contentView().draw(candels: self.candleManager.candles)
        }
    }
    
    func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        onMain {
            guard let currentUnit = self.currentUnit else {
                return
            }
            self.socket?.send(Consts.Socket.subscribe(currentUnit).asComand)
        }
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        onMain {
            self.startTimer()
        }
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        onMain {
            if code == SRStatusCodeNormal.rawValue {
                return
            }
            self.openSocket(unit: self.currentUnit)
        }
    }
    
}
