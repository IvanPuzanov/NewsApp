//
//  AnyCoordinator.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

protocol AnyCoordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
