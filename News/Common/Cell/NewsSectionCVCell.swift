//
//  NewsSectionCVCell.swift
//  News
//
//  Created by Ivan Puzanov on 12.10.2023.
//

import UIKit

final class NewsSectionCVCell: UICollectionViewCell {
    // MARK: UI
    
    private var titleLabel = UILabel()
    
    // MARK: Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Обработка событий
extension NewsSectionCVCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .label
                backgroundColor = .systemGray6
            } else {
                titleLabel.textColor = .secondaryLabel
                backgroundColor = .clear
            }
        }
    }
}

// MARK: - Configurable

extension NewsSectionCVCell: Configurable {
    typealias Model = String
    
    func configure(with model: String) {
        self.titleLabel.text = model
    }
}

// MARK: - Методы конфигурации

private extension NewsSectionCVCell {
    func configure() {
        layer.cornerRadius  = 19
        layer.cornerCurve   = .continuous
    }
    
    func configureTitleLabel() {
        titleLabel = UILabelBuilder()
            .withFont(size: 15, weight: .regular)
            .withTextAlignment(.center)
            .withTextColor(.secondaryLabel)
            .build()
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
