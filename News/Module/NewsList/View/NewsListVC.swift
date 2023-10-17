//
//  NewsListVC.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit
import Combine

final class NewsListVC: UIViewController {
    // MARK: Параметры
    
    private var viewModel: NewsListVM
    
    // MARK: Combine
    
    private var input       = PassthroughSubject<NewsListVM.Input, Never>()
    private var disposeBag  = Set<AnyCancellable>()
    
    // MARK: UI
    
    private var collectionView = NewsCollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Инициализация
    
    init(viewModel: NewsListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Методы жизненного цикла

extension NewsListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureCollectionView()
        
        bindViewModel()
        
        input.send(.fetchNews)
    }
}

// MARK: - Методы обработки событий

private extension NewsListVC {
    func bindViewModel() {
        let output = viewModel.transform(input.eraseToAnyPublisher())
        
        output.sink { [weak self] event in
            switch event {
            case .newsDidFetch(let sections, let news):
                self?.collectionView.update(with: (sections, news))
            case .newsDidFilter(let sections, let news):
                self?.collectionView.update(with: (sections, news))
            case .errorOccured(let errorDescription):
                print(errorDescription)
            }
        }.store(in: &disposeBag)
    }
}

// MARK: - Методы конфигурации

private extension NewsListVC {
    func configure() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Breaking News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDelegate

extension NewsListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let news = self.collectionView.news(at: indexPath) {
            input.send(.openDetail(news: news))
        }
        
        if let section = self.collectionView.section(at: indexPath) {
            input.send(.filterNews(bySection: section))
        }
    }
}
