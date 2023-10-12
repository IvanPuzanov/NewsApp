//
//  Reusable.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

protocol Reusable {
    static var id: String { get }
}

extension Reusable {
    static var id: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}
