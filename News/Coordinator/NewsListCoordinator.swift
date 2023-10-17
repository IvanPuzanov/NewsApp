//
//  NewsListCoordinator.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class NewsListCoordinator: AnyCoordinator {
    // MARK: - Параметры
    
    var newsListAssembly: NewsListAssembly
    var navigationController: UINavigationController
    
    // MARK: - Инициализация
    
    init(newsListAssembly: NewsListAssembly, navigationController: UINavigationController) {
        self.newsListAssembly = newsListAssembly
        self.navigationController = navigationController
    }
    
    // MARK: - Методы
    
    func start() {
        let viewController = newsListAssembly.makeNewsListModule(output: self)
        
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension NewsListCoordinator: NewsListModuleOutput {
    func openDetail(for news: News) {
        let viewController = NewsDetailAssemblly().makeNewsDetailModule(news: news)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
