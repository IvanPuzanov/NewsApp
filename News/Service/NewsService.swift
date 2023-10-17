//
//  NewsService.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class NewsService {
    // MARK: - Параметры
    
    private var networkService: NetworkService
    private var urlRequestFactory: URLRequestFactory
    
    // MARK: - Инициализация
    
    init(networkService: NetworkService, urlRequestFactory: URLRequestFactory) {
        self.networkService = networkService
        self.urlRequestFactory = urlRequestFactory
    }
    
    // MARK: - Методы
     
    func fetchNews(completion: @escaping (Result<NewsResult, NetworkError>) -> Void) {
        do {
            let urlRequest = try urlRequestFactory.getNewsRequests()
            networkService.sendRequest(urlRequest, completion: completion)
        } catch {}
    }
}
