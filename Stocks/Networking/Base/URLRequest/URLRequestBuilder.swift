//
//  URLRequestBuilder.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

final class URLRequestBuilder {
}

extension URLRequestBuilder: URLRequestBuilderProtocol {
    func buildRequest(_ api: NetworkAPI) -> URLRequest? {
        var urlComponents = URLComponents(string: api.baseURL.absoluteString)
        urlComponents?.path = api.path
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method.urlSessionMethod
        
        return request
    }
}
