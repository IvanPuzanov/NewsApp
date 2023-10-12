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
    
    func set(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    /// Метод для создания активных кнопок в окне уведомления
    /// - Parameter buttons: Внутри замыкания происходит конфигурация кнопок
    func set(buttons: () -> [UIButton]) {
        buttons().forEach { button in
            buttonsStackView.addArrangedSubview(button)
        }
    }
}
