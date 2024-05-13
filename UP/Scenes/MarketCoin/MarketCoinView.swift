//
//  MarketCoinView.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import SwiftUI

struct MarketCoinView: View {
    
    @StateObject
    private var viewModel = MarketCoinViewModel()
    
    var body: some View { 
        NavigationStack {
            VStack {
                List {
                    /*
                     .enumerated() 메소드를 사용하면 EnumeratedSequence<[YourType]> 타입을 반환하는데,
                     이 타입은 RandomAccessCollection을 준수하지 않는다.
                     그래서, Array() 로 감싸서 사용해야한다.
                     
                     이 표현식의 결과 타입은 [(offset: Int, element: MarketCoinViewModel.CoinInfo)]
                     참고로, 값이 섞인 Array 가 되었기에 id 도 고유성을 갖는 요소인 element 로 지정해주어야 함!
                     */
                    ForEach(Array(viewModel.output.coinInfo.enumerated()), id: \.element) { index, item in
                        NavigationLink(value: item) {
                            HStack {
                                VStack {
                                    Text(item.marketData.koreanName)
                                    Text(item.marketData.market)
                                }
                                .frame(width: 100, height: 44)
                                Text("\(item.ticker.tradePrice.formatted())₩")
                            }
                            .border(Color.red, width: viewModel.output.changeIndex == index ? 2 : 0)
                            .animation(.default, value: viewModel.output.changeIndex)
                        }
                    }
                } // List
            } // VStack
            .navigationTitle("Market")
        } // NavigationStack
        .onAppear {
            viewModel.action(.marketFetchTrigger)
        }
        .alert(viewModel.output.errorMessage, isPresented: $viewModel.output.isShowingAlertView) {
            Button("취소", role: .cancel) {
                print("취소")
            }
            Button("재시도") {
                viewModel.action(.marketFetchTrigger)
            }
        } 
    }
}

#Preview {
    MarketCoinView()
}
