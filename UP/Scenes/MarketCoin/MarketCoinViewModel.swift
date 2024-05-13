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
        
    }
    
    struct Output {
        
    }
    
    func transform() {
        
    }
}
