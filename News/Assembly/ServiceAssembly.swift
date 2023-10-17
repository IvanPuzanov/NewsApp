//
//  ServiceAssembly.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class ServiceAssembly {
    // MARK: - Параметры
    
    private lazy var networkService: NetworkService = {
        NetworkService()
    }()
    
    func makeNewsService() -> NewsService {
        return NewsService(networkService: networkService,
                           urlRequestFactory: URLRequestFactory(host: "api.nytimes.com"))
    }
    
    func makeCoreDataService() -> CoreDataService {
        return CoreDataService()
    }
}
