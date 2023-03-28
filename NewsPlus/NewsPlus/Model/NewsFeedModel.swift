//
//  NewsFeedModel.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

struct NewsFeed: Codable, Equatable {
    
    let title: String?
    let publishDate: String?
    let feedUpdatedDate: String?
    let feedType: String?
    let typeAttributes: TypeAttributes
    enum CodingKeys: String, CodingKey {
        case title
        case publishDate = "readablePublishedAt"
        case feedUpdatedDate = "readableUpdatedAt"
        case feedType = "type"
        case typeAttributes
    }
    
    static func == (lhs: NewsFeed, rhs: NewsFeed) -> Bool {
        lhs.title == rhs.title
    }
}

struct TypeAttributes: Codable {
    let imageUrl: String?
    enum CodingKeys: String, CodingKey {
        case imageUrl = "imageLarge"
    }
    
}
