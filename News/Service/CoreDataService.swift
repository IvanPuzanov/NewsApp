//
//  CoreDataService.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import CoreData

protocol CoreDataServiceProtocol {
    func cacheData()
    func fetchCachedData() throws -> [CacheNews]
}

final class CoreDataService {
    // MARK: Параметры
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBNews")
        container.loadPersistentStores { _, error in
            guard let error else { return }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// MARK: - CoreDataServiceProtocol

extension CoreDataService: CoreDataServiceProtocol {
    func cacheData() {
    }
    
    func fetchCachedData() throws -> [CacheNews] {
        let cacheNewsFetchRequest = CacheNews.fetchRequest()
        
        return try viewContext.fetch(cacheNewsFetchRequest)
    }
}
