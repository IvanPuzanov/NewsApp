//
//  NewsImageView.swift
//  News
//
//  Created by Ivan Puzanov on 11.09.2023.
//

import UIKit

final class NewsImageView: UIImageView {
    // MARK: Параметры
    
    private var imageLoader: UIImageLoaderProtocol = UIImageLoader.shared
    
    // MARK: UI
    
    private var gradientLayer   = CAGradientLayer()
    private var stackView       = UIStackView()
    private var dateLabel       = UILabel()
    private var authorLabel     = UILabel()
    
    // MARK: Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureGradientLayer()
        configureStackView()
        configureDateLabel()
        configureAuthorLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Метод установки значений

extension NewsImageView: Configurable {
    typealias Model = News
    
    func configure(with model: News) {
        if let url = model.multimedia?.filter({ $0.format == .regular }).first?.url {
            imageLoader.load(url, for: self)
        }
        
        dateLabel.text = "September 5"
        authorLabel.text = model.author
    }
    
    func cancelLoading() {
        imageLoader.cancel(for: self)
        
        DispatchQueue.main.async {
            self.image = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame     = bounds
        gradientLayer.isHidden  = false
    }
}

// MARK: - Методы конфигурации

private extension NewsImageView {
    func configure() {
        contentMode = .scaleAspectFill
        
        backgroundColor     = .systemGray6
        layer.cornerCurve   = .continuous
        layer.cornerRadius  = 27
        clipsToBounds       = true
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureGradientLayer() {
        gradientLayer.colors    = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.isHidden  = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11)
        ])
    }
    
    func configureDateLabel() {
        dateLabel = UILabelBuilder()
            .withFont(size: 14, weight: .regular)
            .withTextAlignment(.center)
            .withTextColor(.white.withAlphaComponent(0.8))
            .build()
        
        stackView.addArrangedSubview(dateLabel)
    }
    
    func configureAuthorLabel() {
        authorLabel = UILabelBuilder()
            .withFont(size: 16, weight: .medium)
            .withTextAlignment(.center)
            .withTextColor(.white)
            .build()
        
        stackView.addArrangedSubview(authorLabel)
    }
}
