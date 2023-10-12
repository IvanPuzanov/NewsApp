//
//  ImageLoader.swift
//  News
//
//  Created by Ivan Puzanov on 12.09.2023.
//

import UIKit

final class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequest = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.runningRequest.removeValue(forKey: uuid) }
            
            if let data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
            }
            
            guard let error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
        runningRequest[uuid] = task
        
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequest[uuid]?.cancel()
        runningRequest.removeValue(forKey: uuid)
    }
}

