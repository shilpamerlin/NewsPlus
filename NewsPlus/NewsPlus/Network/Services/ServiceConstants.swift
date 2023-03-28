//
//  ServiceConstants.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

// swiftlint:disable:next line_length
enum ServiceConstants {
    static let baseURL = "https://www.cbc.ca/aggregate_api/v1/items"
    static let fetchNewsFeed = "?lineupSlug=news&categorySet=cbc-news-apps&typeSet=cbc-news-apps-feed-v2&excludedCategorySet=cbc-news-apps-exclude&page=1&pageSize=20"
    
}
