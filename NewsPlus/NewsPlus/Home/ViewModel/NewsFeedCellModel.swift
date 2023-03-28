//
//  NewsFeedCellModel.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

class NewsFeedCellModel {
    
    // MARK: - Properties
    
    let title: String?
    let publishDate: String?
    let feedUpdateDate: String?
    let feedType: String?
    let imageUrl: String?
    
    init(with newsFeed: NewsFeed) {
        title = newsFeed.title
        publishDate = newsFeed.publishDate
        feedUpdateDate = newsFeed.feedUpdatedDate
        feedType = newsFeed.feedType
        imageUrl = newsFeed.typeAttributes.imageUrl
    }
}
