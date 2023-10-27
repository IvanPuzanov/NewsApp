//
//  UIButtonBuilder.swift
//  News
//
//  Created by Ivan Puzanov on 27.10.2023.
//

import UIKit

final class UIButtonBuilder {
    // MARK: Параметры
    
    private var button          = UIButton()
    private var title           = String()
    private var titleAttributes = [NSAttributedString.Key: Any]()
    
    // MARK: Методы
    
    func withTitle(_ title: String) -> UIButtonBuilder {
        self.title = title
        return self
    }
    
    func withFont(size: CGFloat, weight: UIFont.Weight) -> UIButtonBuilder {
        titleAttributes[.font] = UIFont.systemFont(ofSize: size, weight: weight)
        return self
    }
    
    func withTextColor(_ color: UIColor) -> UIButtonBuilder {
        titleAttributes[.foregroundColor] = color
        return self
    }
    
    func withBackgroundColor(_ color: UIColor) -> UIButtonBuilder {
        button.backgroundColor = color
        return self
    }
    
    func withCorner(curve: CALayerCornerCurve = .continuous, radius: CGFloat) -> UIButtonBuilder {
        button.layer.cornerCurve    = curve
        button.layer.cornerRadius   = radius
        return self
    }
    
    func build() -> UIButton {
        button.setAttributedTitle(NSAttributedString(string: title, attributes: titleAttributes), for: .normal)
        return button
    }
}
