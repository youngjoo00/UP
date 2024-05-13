//
//  TickerManager.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

// 어떻게 해야 네트워크 통신처럼 하나로 사용할 수 있을까..
import Foundation
import Combine

final class TickerManager: NSObject {
    
    static let shared = TickerManager()
    private override init() {}
    
    private var websocket: URLSessionWebSocketTask?
    private var isOpen = false
    private var timer: Timer?
    var tickerSubject = PassthroughSubject<Ticker, Never>()
    
    // setting open/close
    func openWebSocket() {
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            URLSession.shared.dataTask(with: url).resume() // 의문점 1. 여길 왜하는거지?
            
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            websocket = session.webSocketTask(with: url)
            websocket?.resume()
            
            ping()
        }
    }
    
    func closeWebSocket() {
        websocket?.cancel(with: .goingAway, reason: nil)
        websocket = nil
        
        timer?.invalidate()
        timer = nil
        
        isOpen = false
    }
}

extension TickerManager: URLSessionWebSocketDelegate {
    
    // 소켓 통신 Open
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Socket Open")
        
        isOpen = true
        // 소켓 통로가 오픈 된 이후 -> 쏟아져나오는 서버의 응답값을 받음
        receiveSocketData()
    }
    
    // 소켓 통신 Close
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Socket Close")
        
        isOpen = false
    }
}

extension TickerManager {
    
    // request Body
    func send(_ string: String) {
        websocket?.send(.string(string)) { error in
            print("send:", error)
        }
    }
    
    private func receiveSocketData() {
        if isOpen {
            websocket?.receive { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    switch success {
                    case .data(let data):
                        do {
                            let decodedData = try JSONDecoder().decode(Ticker.self, from: data)
                            self.tickerSubject.send(decodedData)
                        } catch {
                            print("디코딩 실패: \(error)")
                        }
                    case .string(let string): print(string)
                    @unknown default: print("ok")
                    }
                case .failure(let failure):
                    print(failure)
                }
                self.receiveSocketData()
            }
        }
    }
    
    private func ping() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] timer in
            self?.websocket?.sendPing { error in
                if let error {
                    print("ping Error: ", error.localizedDescription)
                } else {
                    print("good")
                }
            }
        }
    }
    
}
