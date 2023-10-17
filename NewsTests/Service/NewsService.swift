//
//  NewsService.swift
//  NewsTests
//
//  Created by Ivan Puzanov on 13.09.2023.
//

@testable import News
import XCTest

final class NewsServiceTests: XCTestCase {
    
    func testNewsRequest() {
        let serviceAssembly = ServiceAssembly()
        let newsService = serviceAssembly.makeNewsService()
        
        newsService.fetchNews { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
}
