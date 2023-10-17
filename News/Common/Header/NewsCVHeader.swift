//
//  NewsCVHeader.swift
//  News
//
//  Created by Ivan Puzanov on 13.10.2023.
//

import UIKit

final class NewsCVHeader: UICollectionReusableView {
    
    enum Section { case main }
    
    // MARK: Параметры
    
    private var collectionViewLayout: UICollectionViewCompositionalLayout?
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, String>?
    
    // MARK: UI
    
    private var sectionsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Методы конфигурации

private extension NewsCVHeader {
    func configure() {
        
    }
}
