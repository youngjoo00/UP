//
//  MarketCoinViewModel.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Combine
import Foundation

final class MarketCoinViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    init() {
        transform()
    }
}

extension MarketCoinViewModel {
 
    struct Input {
        let marketFetchTrigger = PassthroughSubject<Void, Never>()
    }
    
    enum Action {
        case marketFetchTrigger
    }
    
    func action(_ action: Action) {
        switch action {
        case .marketFetchTrigger:
            input.marketFetchTrigger.send(())
        }
    }
    
    struct Output {
        var isShowingAlertView: Bool = false
        var errorMessage: String = ""
        var coinInfo: [CoinInfo] = []
        var changeIndex: Int?
    }
    
    // Hashable 을 사용할 때 내부 구조체도 모두 Hashable 프로토콜을 채택한 상태여야 한다!!!!
    struct CoinInfo: Hashable, Identifiable {
        var id = UUID()
        var marketData: Market
        var ticker: Ticker
    }
    
    func transform() {
        let MarketsSubject = PassthroughSubject<Markets, Never>()
        
        input.marketFetchTrigger
            .flatMap { _ in
                NetworkManager.shared.callAPI(response: Markets.self, request: UpbitRouter.market)
                    .catch { [weak self] error in // 에러 발생시 Alert
                        print("에러: ", error.localizedDescription)
                        self?.output.errorMessage = error.localizedDescription
                        self?.output.isShowingAlertView = true
                        return Just(Markets()) // 비어있는 Market 배열 생성해서 반환
                    }
            } // 에러가 있든 없든 진행
            .receive(on: DispatchQueue.main)
            .sink { [weak self] markets in
                self?.output.coinInfo = markets.map { market in
                    CoinInfo(marketData: market, ticker: Ticker(type: "", code: "", openingPrice: 0, highPrice: 0, lowPrice: 0, tradePrice: 0, prevClosingPrice: 0, change: "", changePrice: 0, signedChangePrice: 0, changeRate: 0, signedChangeRate: 0, tradeVolume: 0, accTradeVolume: 0, accTradeVolume24h: 0, accTradePrice: 0, accTradePrice24h: 0, tradeDate: "", tradeTime: ""))
                }
                 
                MarketsSubject.send(markets)
            }
            .store(in: &self.cancellables)
        
        MarketsSubject
            .sink { markets in
                let codes = markets
                    .map { $0.market }
                TickerManager.shared.openWebSocket()
                
                TickerManager.shared.send(
                    """
                       [{"ticket":"test"},{"type":"ticker","codes":\(codes)}]

                    """
                )
            }
            .store(in: &cancellables)
        
        // 이렇게 묶는구나..
        Publishers.CombineLatest(MarketsSubject, TickerManager.shared.tickerSubject)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] markets, ticker in
                
                // 1. firstIndex 로 첫번쨰로 맞는 값의 인덱스를 찾고, 그 인덱스에 값을 넣어주는 형식으로
                let index = markets.firstIndex { info in
                    return info.market == ticker.code
                }
                
                // 2. 아웃풋으로 방출
                if let index {
                    self?.output.coinInfo[index].ticker = ticker
                    self?.output.changeIndex = index
                }
            }
            .store(in: &cancellables)
    }
}

extension MarketCoinViewModel {
    
    
}


/*
 Just 사용 예시
 import Combine

 let justPublisher = Just("Hello, Combine!")

 justPublisher
     .sink(receiveCompletion: { completion in
         switch completion {
         case .finished:
             print("완료")
         case .failure(let error):
             print("에러 발생: \(error)")
         }
     }, receiveValue: { value in
         print("받은 값: \(value)")
     })

 */
