//
//  NewsListVieModel.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit
import Combine

final class NewsListVM {
    // MARK: Сервисы
    
    private var newsService: NewsService
    private var newsListModuleOutput: NewsListModuleOutput
    private var coreDataService: CoreDataServiceProtocol
    
    // MARK: Параметры
    
    private var news: [News]        = []
    private var sections: [String]  = []
    
    // MARK: View Model
    
    enum Input {
        case fetchNews
        case filterNews(bySection: String)
        case openDetail(news: News)
    }
    
    enum Output {
        case newsDidFetch(sections: [String], news: [News])
        case newsDidFilter(sections: [String], news: [News])
        case errorOccured(description: String)
    }
    
    // MARK: Combine
    
    private var output      = PassthroughSubject<Output, Never>()
    private var disposeBag  = Set<AnyCancellable>()
    
    // MARK: Инициализация
    
    init(newsService: NewsService, newsListModuleOutput: NewsListModuleOutput, coreDataService: CoreDataServiceProtocol) {
        self.newsService            = newsService
        self.newsListModuleOutput   = newsListModuleOutput
        self.coreDataService        = coreDataService
    }
    
    // MARK: Метод связывания
    
    func transform(_ input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .fetchNews:
                self?.fetchNews()
            case .filterNews(let section):
                self?.filterNews(with: section)
            case .openDetail(let news):
                self?.openDetail(for: news)
            }
        }.store(in: &disposeBag)
        
        return output.eraseToAnyPublisher()
    }
}

// MARK: - Методы

private extension NewsListVM {
    /// Метод запроса новостей
    func fetchNews() {
        newsService.fetchNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news.results
                
                let news = news.results
                let sections = self?.filterSections(in: news)
                
                if let sections {
                    self?.output.send(.newsDidFetch(sections: sections, news: news))
                }
            case .failure(let error):
                self?.output.send(.errorOccured(description: error.rawValue))
            }
        }
    }
    
    /// Метод фильтрации новостей по секциям
    /// - Parameter news: Массив новостей
    /// - Returns: Массив секций
    func filterSections(in news: [News]) -> [String] {
        var sections = ["All"]
        
        news.forEach { model in
            if !sections.contains(where: { $0.lowercased() == model.section.lowercased() }) {
                sections.append(model.section.capitalized)
            }
        }
        
        self.sections = sections
        
        return sections
    }
    
    /// Фильтровать новости по секцияи
    /// - Parameter section: Секция для фильтрации
    func filterNews(with section: String) {
        guard section.lowercased() != "All".lowercased() else {
            output.send(.newsDidFilter(sections: self.sections, news: self.news))
            return
        }
        
        let filteredNews = self.news.filter { $0.section.lowercased() == section.lowercased() }
        
        output.send(.newsDidFilter(sections: self.sections, news: filteredNews))
    }
    
    func openDetail(for news: News) {
        newsListModuleOutput.openDetail(for: news)
    }
}
