//
//  NetworkProvider.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Combine
import Foundation

protocol NetworkProviderProtocol {
    func fetch(from request: URLRequest) -> AnyPublisher<Response<Data>, Error>
}

final class NetworkProvider {
}

extension NetworkProvider: NetworkProviderProtocol {
    func fetch(from request: URLRequest) -> AnyPublisher<Response<Data>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError { error in
                return NetworkError.unknownError
            }
            .tryMap { result -> Response<Data> in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.badResponse(response: result.response)
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return Response(data: result.data, response: result.response)
                case 400..<500:
                    throw NetworkError.badRequest(response: httpResponse)
                case 500...:
                    throw NetworkError.serverError(response: httpResponse)
                default:
                    throw NetworkError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
}
