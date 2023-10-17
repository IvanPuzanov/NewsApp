//
//  Configurable.swift
//  News
//
//  Created by Ivan Puzanov on 11.09.2023.
//

import UIKit

/// Протокол гарантирующий конфигурируемость ячейки
protocol Configurable {
    associatedtype Model
    
    func configure(with model: Model)
}
