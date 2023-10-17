//
//  News.swift
//  News
//
//  Created by Ivan Puzanov on 06.09.2023.
//

import Foundation

struct NewsResult: Decodable {
    let results: [News]
}

struct News: Decodable {
    let id = UUID()
    
    let section: String
    let title: String?
    let abstract: String?
    let url: URL
    let multimedia: [NewsMultimedia]?
    let author: String?
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case section, title, abstract, url, multimedia
        case author = "byline"
        case date   = "published_date"
    }
}

extension News: Hashable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {}
}

struct NewsMultimedia: Decodable {
    let format: MediaFormat
    let url: URL
    
    enum MediaFormat: String, Decodable {
        case thumb      = "Large Thumbnail"
        case regular    = "threeByTwoSmallAt2X"
        case large      = "Super Jumbo"
    }
}
