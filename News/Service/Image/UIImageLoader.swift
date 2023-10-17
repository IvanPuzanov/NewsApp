//
//  UIImageLoader.swift
//  News
//
//  Created by Ivan Puzanov on 12.09.2023.
//

import UIKit
import Combine

protocol UIImageLoaderProtocol {
    func load(_ url: URL, for imageView: UIImageView)
    func cancel(for imageView: UIImageView)
}

final class UIImageLoader {
    static let shared = UIImageLoader()
    
    private var imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
}

extension UIImageLoader: UIImageLoaderProtocol {
    func load(_ url: URL, for imageView: UIImageView) {
        let uuid = imageLoader.loadImage(url) { result in
            
            defer { self.uuidMap.removeValue(forKey: imageView) }
            
            do {
                let image = try result.get()
                
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                print("Ошибка при получении картинки \(url)")
            }
        }
        
        uuidMap[imageView] = uuid
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
        }
    }
}
