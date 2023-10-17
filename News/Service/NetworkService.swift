//
//  NetworkService.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import UIKit

enum NetworkError: String, Error {
    case errorOccured = ""
    case badResponse
    case badData
    case failToDecode
}

final class NetworkService {
    
    // MARK: - Параметры
    
    private var urlSession: URLSession
    private var jsonDecoder = JSONDecoder()
    
    // MARK: - Инициализация
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Методы
    
    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else {
                completion(.failure(.errorOccured))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                guard let decodedData = try self?.jsonDecoder.decode(T.self, from: data) else {
                    completion(.failure(.failToDecode))
                    return
                }
                
                completion(.success(decodedData))
            } catch {
                completion(.failure(.failToDecode))
            }
        }.resume()
    }
}
