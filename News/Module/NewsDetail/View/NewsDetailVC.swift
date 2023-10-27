//
//  NewsDetailVC.swift
//  News
//
//  Created by Ivan Puzanov on 13.09.2023.
//

import UIKit
import Combine

final class NewsDetailVC: UIViewController {
    // MARK: Параметры
    
    private var viewModel: NewsDetailVM
    
    // MARK: Combine
    
    private let input = PassthroughSubject<NewsDetailVM.Input, Never>()
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: UI
    
    private let imageView   = NewsImageView(frame: .zero)
    private var doneButton = UIButton()
    
    // MARK: Инициализация
    
    init(viewModel: NewsDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle

extension NewsDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureImageView()
        configureDoneButton()
        bindViewModel()
        
        input.send(.configureImageView(imageView))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.1) {
            self.view.subviews.forEach { $0.alpha = 0 }
        }
    }
}

// MARK: - Методы обработки событий

private extension NewsDetailVC {
    func bindViewModel() {
        let output = viewModel.transform(input.eraseToAnyPublisher())
        
        output.sink { event in
            switch event {
            case .errorOccured:
                print("Произошла ошибка")
            }
        }.store(in: &disposeBag)
    }
    
    @objc
    func close() {
        self.dismiss(animated: true)
    }
}

// MARK: - Методы конфигурации

private extension NewsDetailVC {
    func configure() {
        view.backgroundColor = .black
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6)
        ])
    }
    
    func configureDoneButton() {
        doneButton = UIButtonBuilder()
            .withTitle(Title.done)
            .withFont(size: 15, weight: .regular)
            .withBackgroundColor(.systemGray6)
            .withCorner(radius: 22)
            .build()
        
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
