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
                    ForEach(viewModel.output.markets) { item in
                        NavigationLink(value: item) {
                            Text(item.market)
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
