//
//  CbcEndPoint.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

public enum CbcEndPoint {
    case fetchNewsFeed
    // Add more cases based on app requirements
}

/// confirms to protocol EndPointType
extension CbcEndPoint: EndPointType {
    
    var baseURL: String {
        return ServiceConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchNewsFeed:
            return ServiceConstants.fetchNewsFeed
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchNewsFeed:
            return .get
        }
    }
}
