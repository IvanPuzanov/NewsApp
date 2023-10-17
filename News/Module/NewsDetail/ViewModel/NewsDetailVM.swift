//
//  NewsDetailVM.swift
//  News
//
//  Created by Ivan Puzanov on 13.09.2023.
//

import UIKit
import Combine

final class NewsDetailVM {
    // MARK: Параметры
    
    private var news: News
    
    // MARK: ViewModel
    
    enum Input {
        case configureImageView(NewsImageView)
    }
    
    enum Output {
        case errorOccured
    }
    
    // MARK: Combine
    
    private var output = PassthroughSubject<Output, Never>()
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: Инициализация
    
    init(news: News) {
        self.news = news
    }
    
    // MARK: Метод связывания
    
    func transform(_ input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .configureImageView(let imageView):
                self?.configureImageView(imageView)
            }
        }.store(in: &disposeBag)
        
        return output.eraseToAnyPublisher()
    }
}

// MARK: - Методы

private extension NewsDetailVM {
    func configureImageView(_ imageView: NewsImageView) {
        imageView.configure(with: news)
    }
}
