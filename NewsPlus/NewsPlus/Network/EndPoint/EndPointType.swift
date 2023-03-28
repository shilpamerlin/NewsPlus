//
//  EndPointType.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

// HTTPMethodTypes
enum HTTPMethod: String {
    // implement more when needed: post, put, delete etc.
    case get = "GET"
}

/// Protocol to which every Api service should confirm to
protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}
