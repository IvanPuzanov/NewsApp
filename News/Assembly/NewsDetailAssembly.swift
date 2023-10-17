//
//  NewsDetailAssembly.swift
//  News
//
//  Created by Ivan Puzanov on 13.09.2023.
//

import UIKit

final class NewsDetailAssemblly {
    // MARK: Методы
    
    func makeNewsDetailModule(news: News) -> UIViewController {
        let viewModel = NewsDetailVM(news: news)
        let viewController = NewsDetailVC(viewModel: viewModel)
        
        return viewController
    }
}
