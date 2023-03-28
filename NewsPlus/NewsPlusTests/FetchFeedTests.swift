//
//  CBCNewsFeedTests.swift
//  CBCNewsFeedTests
//
//  Created by Shilpa Joy on 2023-02-22.
//

import XCTest
import SystemConfiguration
@testable import CBCNewsFeed

final class FetchFeedTests: XCTestCase {
    
    var viewModel: NewsFeedViewModel!
    var viewController: NewsFeedViewController!
    var apiClient: ServiceProvider<CbcEndPoint>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = NewsFeedViewModel()
        apiClient = ServiceProvider()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testGetJsonFeedResponse() throws {
        apiClient.load(endPoint: .fetchNewsFeed,
                       decodeType: [NewsFeed].self) { response in
            switch response {
            case.failure(let error):
                XCTAssertNotNil(error)
            case .success(let newsFeed):
                XCTAssertNotNil(newsFeed)
            }
        }
    }
    
    func testRetreiveFeedFromCache() throws {
        viewModel.fetchFeedFromCache()
        XCTAssertNotNil(viewModel.numberOfCellModels)
    }
    
    func testShowDiffeerentViewsForiPad() throws {
        if UIDevice().userInterfaceIdiom == .pad {
            XCTAssertNotNil(viewController.feedCollectionView)
            XCTAssertNil(viewController.newsFeedTableView)
        }
    }
}
