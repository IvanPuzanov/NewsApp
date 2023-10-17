//
//  NewsCollectionView.swift
//  News
//
//  Created by Ivan Puzanov on 13.09.2023.
//

import UIKit

final class NewsCollectionView: UICollectionView {
    
    enum Section: Int { case newsSection, news }
    
    // MARK: Параметры
    private var newsDataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    
    // MARK: Инициализация
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        configure()
        configureLayout()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Публичные методы

extension NewsCollectionView {
    func update(with data: (sections: [String], news: [News])) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.newsSection, .news])
        snapshot.appendItems(data.sections, toSection: .newsSection)
        snapshot.appendItems(data.news, toSection: .news)
        
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9) {
                self?.newsDataSource?.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    func news(at indexPath: IndexPath) -> News? {
        let news = newsDataSource?.itemIdentifier(for: indexPath) as? News
        return news
    }
    
    func section(at indexPath: IndexPath) -> String? {
        let section = newsDataSource?.itemIdentifier(for: indexPath) as? String
        return section
    }
}

// MARK: - Методы конфигурации

private extension NewsCollectionView {
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        register(NewsSectionCVCell.self, forCellWithReuseIdentifier: NewsSectionCVCell.id)
        register(NewsRegularCVCell.self, forCellWithReuseIdentifier: NewsRegularCVCell.id)
    }
    
    func configureLayout() {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            let collectionSection = Section(rawValue: section)
            
            switch collectionSection {
            case .newsSection:
                let size    = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                                     heightDimension: .estimated(50))
                
                let item    = NSCollectionLayoutItem(layoutSize: size)
                
                let group   = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            case .news:
                let size    = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .estimated(300))
                
                let item    = NSCollectionLayoutItem(layoutSize: size)
                item.contentInsets = .init(top: 0, leading: 16, bottom: 15, trailing: 16)
                
                let group   = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            default:
                return nil
            }
            
        }
        
        self.collectionViewLayout = layout
    }
    
    func configureDataSource() {
        typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
        newsDataSource = DataSource(collectionView: self, cellProvider: { [weak self] collectionView, indexPath, item in
            
            let collectionSection = Section(rawValue: indexPath.section)
            
            switch collectionSection {
            case .newsSection:
                let cell = self?.dequeueReusableCell(withReuseIdentifier: NewsSectionCVCell.id, for: indexPath) as? NewsSectionCVCell
                
                if let item = item as? String {
                    cell?.configure(with: item)
                }
                
                return cell
            case .news:
                let cell = self?.dequeueReusableCell(withReuseIdentifier: NewsRegularCVCell.id, for: indexPath) as? NewsRegularCVCell
                
                if let item = item as? News {
                    cell?.configure(with: item)
                }
                
                return cell
            default:
                return nil
            }
        })
    }
}
