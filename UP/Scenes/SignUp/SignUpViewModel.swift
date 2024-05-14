//
//  SignUpViewModel.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import Combine
import Foundation

final class SignUpViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init() {
        transform()
    }
}

extension SignUpViewModel {
 
    struct Input {
    }
    
    enum Action {
    }
    
    func action(_ action: Action) {
      
    }
    
    struct Output {
        var errorMessage = ""
    }
    
    func transform() {
        // Publisher -> $를 사용하여 접근
        $email
            .sink { email in
                print("이메일 입력값: \(email)")
            }
            .store(in: &cancellables)
        
        $password
            .sink { password in
                print("패스워드 입력값: \(password)")
            }
            .store(in: &cancellables)
    }
}
