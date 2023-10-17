//
//  NewsListAssembly.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class NewsListAssembly {
    // MARK: - Параметры
    
    private var serviceAssembly: ServiceAssembly
    
    // MARK: - Инициализация
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - Методы
    
    func makeNewsListModule(output: NewsListModuleOutput) -> UIViewController {
        let newsService     = serviceAssembly.makeNewsService()
        let coreDataService = serviceAssembly.makeCoreDataService()
        let viewModel       = NewsListVM(newsService: newsService,
                                         newsListModuleOutput: output,
                                         coreDataService: coreDataService)
        let viewController  = NewsListVC(viewModel: viewModel)
        
        return viewController
    }
}
