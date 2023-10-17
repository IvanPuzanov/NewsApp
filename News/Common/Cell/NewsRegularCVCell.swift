//
//  NewsRegularCVCell.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class NewsRegularCVCell: UICollectionViewCell {    
    // MARK: UI
    
    private var imageView           = NewsImageView(frame: .zero)
    private var titleLabel          = UILabel()
    private var abstractLabel       = UILabel()
    
    // MARK: Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureImageView()
        configureTitleLabel()
        configureAbstractLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Метод установки значений ячейки

extension NewsRegularCVCell: Configurable {
    typealias Model = News
    
    func configure(with model: News) {
        imageView.configure(with: model)
        titleLabel.text = model.title
        abstractLabel.text = model.abstract
    }
    
    func getNewsImageView() -> NewsImageView {
        return imageView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelLoading()
    }
}

// MARK: - Методы конфигурации

private extension NewsRegularCVCell {
    func configure() {
        clipsToBounds = true
    }
    
    func configureImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 5/7)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel = UILabelBuilder()
            .withFont(size: 16, weight: .semibold)
            .withTextColor(.label.withAlphaComponent(0.95))
            .withNumberOfLines(3)
            .build()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7)
        ])
    }
    
    func configureAbstractLabel() {
        abstractLabel = UILabelBuilder()
            .withFont(size: 14, weight: .regular)
            .withTextColor(.secondaryLabel)
            .withNumberOfLines(3)
            .build()
        
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(abstractLabel)
        
        NSLayoutConstraint.activate([
            abstractLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            abstractLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            abstractLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            abstractLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
