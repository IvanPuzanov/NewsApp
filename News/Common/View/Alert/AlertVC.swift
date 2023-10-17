//
//  AlertVC.swift
//  News
//
//  Created by Ivan Puzanov on 12.09.2023.
//

import UIKit

final class AlertVC: UIViewController {
    
    // MARK: UI
    
    private let containerView       = UIView()
    private var titleLabel          = UILabel()
    private var messageLabel        = UILabel()
    private let buttonsStackView    = UIStackView()
    
    // MARK: Инициализация
    
}

// MARK: - Методы настройки

extension AlertVC {
    /// Метод установки заголовка и сообщения уведомления
    /// - Parameters:
    ///   - title: Заголовок уведомления
    ///   - message: Сообщение уведомления
    func set(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    /// Метод для создания активных кнопок в окне уведомления
    /// - Parameter buttons: Внутри замыкания происходит конфигурация кнопок. Кнопки располагаются в порядке нахождения в массиве.
    func set(buttons: () -> [UIButton]) {
        buttons().forEach { button in
            buttonsStackView.addArrangedSubview(button)
        }
    }
}

// MARK: - Методы конфигурации

private extension AlertVC {
    func configure() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor       = .systemBackground
        containerView.layer.cornerCurve     = .continuous
        containerView.layer.cornerRadius    = 20
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButtonsStackView() {
        
    }
    
    func configureMessageLabel() {
        
    }
}
