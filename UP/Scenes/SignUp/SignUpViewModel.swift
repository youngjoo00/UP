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
    
    init() {
        transform()
    }
}

extension SignUpViewModel {
 
    struct Input {
        let nextButtonTap = PassthroughSubject<Void, Never>()
    }
    
    enum Action {
        case nextButtonTap
    }
    
    func action(_ action: Action) {
        switch action {
        case .nextButtonTap:
            input.nextButtonTap.send(())
        }
    }
    
    struct Output {
        var errorDescription = ""
        var errorAlertMessage = ""
    }
    
    func transform() {
        input.nextButtonTap
            .flatMap { [weak self] _ -> AnyPublisher<UserResponse.ValidationEmail, APIError> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                let isValid = self.email.validateEmail()
                
                if isValid {
                    let query = UserRequest.ValidationEmail(email: self.email)
                    return NetworkManager.shared.callAPI(response: UserResponse.ValidationEmail.self, request: Router.user(.validationEmail(query: query)))
                } else {
                    output.errorDescription = "이메일 형식이 아닙니다."
                    return Empty().eraseToAnyPublisher() // 캐치구문으로 가지 않고 스트림이 종료됨
                }
            }
            // Empty<UserResponse.ValidationEmail, Never>를 반환하는 것은 실제로 스트림이 바로 종료되도록 하기 위한 것
            // 문법적인 이유로 퍼블리셔로 사용했던 반환값을 Empty 를 통해서 명시해야 한다고 함
            .receive(on: DispatchQueue.main)
            .catch { [weak self] error -> Empty<UserResponse.ValidationEmail, Never> in // 오류가 발생했을 때에만 실행되고, 발생하지 않으면 건너뜀
                self?.output.errorAlertMessage = error.localizedDescription
                return Empty()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                self?.output.errorDescription = response.message
            }
            .store(in: &cancellables)
    }
}
