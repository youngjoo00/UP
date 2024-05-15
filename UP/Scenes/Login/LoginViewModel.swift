//
//  LoginViewModel.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import Combine
import Foundation

final class LoginViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    
    @Published
    var output = Output()
    
    // 이게 맞나..? 점점 이상해지는데,,
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isShowingSignUp = false
    
    init() {
        transform()
    }
}

extension LoginViewModel {
 
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
