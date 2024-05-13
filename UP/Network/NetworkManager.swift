//
//  NetworkManager.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Foundation
import Combine

enum APIResult<T: Decodable> {
    case success(T)
    case fail(APIError)
}

enum EmptyAPIResult {
    case success
    case fail(APIError)
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func callAPI<Response: Decodable, Request: TargetType>(response: Response.Type, request: Request) -> AnyPublisher<Response, APIError> {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.asURLRequest()
        } catch {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data) // .output (data, response) 에서 data 만 뽑아냄
            .decode(type: Response.self, decoder: JSONDecoder()) // 디코딩, tryMap 으로 디코딩하는 방식은 JSONDecoder 를 콜 할때마다 생성하기에 이 방식이 효율적
            .mapError { error -> APIError in // .failure 로 오는 값이 있다면 에러 핸들링
                return .decodingFali
            }
            .eraseToAnyPublisher() // Publishers.MapError<Publishers.Decode<Publishers.Map<URLSession.DataTaskPublisher, Data>, Response, JSONDecoder>, APIError> 형태가 되는게 문제여서 역제네릭타입처럼 구체화된 타입을 숨기고, 추상화된 Publisher 타입으로 변경해줌
        /*
         같은 개념이면 똑같이 쓰면 되는거 아닌가 해서 찾아봄
         
         용도: 불투명 타입은 주로 함수나 메서드의 반환 타입에 대한 추상화를 제공하는 반면,
                eraseToAnyPublisher()는 Combine 프레임워크 내에서 Publisher 타입을 추상화하는 데 사용됩니다.
         구현: 불투명 타입은 some 키워드를 사용하여 구현되고, 컴파일 타임에 타입이 결정됩니다.
                반면, eraseToAnyPublisher()는 런타임에 타입을 AnyPublisher로 감싸는 방식으로 동작합니다.
         */
    }
}
