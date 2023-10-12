//
//  NewsListVieModel.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class NewsListViewModel {
    // MARK: - Параметры
    
    private var newsListModuleOutput: NewsListModuleOutput
    
    // MARK: - Инициализация
    
    init(newsListModuleOutput: NewsListModuleOutput) {
        self.newsListModuleOutput = newsListModuleOutput
    }
}
