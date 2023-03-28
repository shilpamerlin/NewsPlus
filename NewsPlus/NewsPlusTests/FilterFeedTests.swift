//
//  FilterFeedTests.swift
//  CBCNewsFeedTests
//
//  Created by Shilpa Joy on 2023-02-27.
//

import XCTest
@testable import CBCNewsFeed

final class FilterFeedTests: XCTestCase {
    
    var viewModel: FilterViewModel!
    var fetchedFeed: [NewsFeed]!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = FilterViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testRetreiveFeedFromCache() throws {
        PersistanceManager.retreiveNewsFeed { result in
            switch result {
            case .success(let newsFeed):
                self.fetchedFeed = newsFeed
                XCTAssertNotNil(newsFeed)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    
        func testFilterNewsFeedFromCache() throws {
            let selectedType = "story"
            viewModel.filterNewsFeed(selectedType: selectedType) { response in
                XCTAssertNotNil(response)
                let filteredFeed = self.fetchedFeed.filter({ return $0.feedType == selectedType})
                XCTAssertNotNil(filteredFeed)
            }
        }
    }
}



