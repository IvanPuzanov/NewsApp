//
//  UILabelBuilder.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

final class UILabelBuilder {
    // MARK: - Параметры
    
    private var label = UILabel()
    
    // MARK: - Методы конфигурации
    
    func withFont(size: CGFloat, weight: UIFont.Weight) -> UILabelBuilder {
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        return self
    }
    
    func withTextColor(_ color: UIColor) -> UILabelBuilder {
        label.textColor = color
        return self
    }
    
    func withTextAlignment(_ alignment: NSTextAlignment) -> UILabelBuilder {
        label.textAlignment = alignment
        return self
    }
    
    func withNumberOfLines(_ numberOfLines: Int) -> UILabelBuilder {
        label.numberOfLines = numberOfLines
        return self
    }
    
    func build() -> UILabel {
        return label 
    }
}
