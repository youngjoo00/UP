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
            
            }
            .navigationTitle("Market")
        }
    }
}

#Preview {
    MarketCoinView()
}
