//
//  URLRequestFactory.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

protocol AnyURLRequestFactory {
    func getNewsRequests() throws -> URLRequest
}

enum URLRequestFactoryError: Error {
    case failToCreateRequest
}

final class URLRequestFactory {
    private var host: String
    
    init(host: String) {
        self.host = host
    }
}

extension URLRequestFactory: AnyURLRequestFactory {
    func getNewsRequests() throws -> URLRequest {
        guard let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=QauJAWFmlv0WIhtlPKOujZuigpuc2AiK") else {
            throw URLRequestFactoryError.failToCreateRequest
        }
        
        let request = URLRequest(url: url)
        
        return request
    }
}

private extension URLRequestFactory {
    func url(with path: String) -> URL? {
        var urlComponents   = URLComponents()
        urlComponents.host  = host
        urlComponents.path  = path
        
        return urlComponents.url
    }
}
