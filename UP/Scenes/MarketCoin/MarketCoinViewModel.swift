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
        var markets: Markets = []
        var isShowingAlertView: Bool = false
        var errorMessage: String = ""
        //var Tickers: [Ticker] = []
    }
    
    func transform() {
        var testMarkets = PassthroughSubject<Markets, Never>()
        
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
            .sink { [weak self] markets in
                self?.output.markets = markets
                testMarkets.send(markets)
            }
            .store(in: &self.cancellables)
        
        testMarkets
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
        
        TickerManager.shared.tickerSubject
            .sink { [weak self] ticker in
                print(ticker)
                //output.Tickers = [ticker]
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
