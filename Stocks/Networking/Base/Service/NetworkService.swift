//
//  HttpClient.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine
import Foundation

class NetworkService<API: NetworkAPI> {
    private let jsonDecoder: JSONDecoder
    private let urlRequestBuilder: URLRequestBuilderProtocol
    
    init(
        jsonDecoder: JSONDecoder,
        urlRequestBuilder: URLRequestBuilderProtocol
    ) {
        self.jsonDecoder = jsonDecoder
        self.urlRequestBuilder = urlRequestBuilder
    }
    
    func run<T: Decodable>(_ api: API) -> AnyPublisher<Response<T>, Error> {
        guard let request = urlRequestBuilder.buildRequest(api) else {
            return Fail(error: NetworkServiceError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { [jsonDecoder] result -> Response<T> in
                let data = try jsonDecoder.decode(T.self, from: result.data)
                return Response(data: data, response: result.response)
            }
            .mapError({ error in
                print(error)
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
