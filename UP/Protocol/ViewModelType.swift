//
//  ViewModelType.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get set }
    
    func transform()
    
    var input: Input { get set }
    var output: Output { get set }
}
