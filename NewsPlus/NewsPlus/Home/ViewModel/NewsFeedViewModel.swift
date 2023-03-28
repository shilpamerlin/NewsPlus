//
//  NewsFeedViewModel.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

class NewsFeedViewModel {
    
    // MARK: - Properties

    private let serviceProvider: ServiceProvider<CbcEndPoint>
    var reloadView: (() -> Void) = {}
    var updatingStatus: (() -> Void) = {}
    
    init(serviceProvider: ServiceProvider<CbcEndPoint> = ServiceProvider()) {
        self.serviceProvider = serviceProvider
    }

    private var cellViewModels = [NewsFeedCellModel]() {
        didSet {
            self.reloadView()
        }
    }
    var numberOfCellModels: Int {
        return cellViewModels.count
    }
    var isLoading: Bool = false {
        didSet {
            updatingStatus()
        }
    }
    
    func fetchNewsFeed() {
        self.isLoading = true
        serviceProvider.load(endPoint: .fetchNewsFeed,
                             decodeType: [NewsFeed].self) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case.failure(let error):
                print("Error occured\(error)")
            case .success(let newsFeed):
                PersistanceManager.save(newsFeed: newsFeed)
                self.processFetchedData(newsFeed: newsFeed)
                self.isLoading = false
            }
        }
    }
    
    func processFetchedData(newsFeed: [NewsFeed]) {
        var cellModel = [NewsFeedCellModel]()
        for feed in newsFeed {
            let model = NewsFeedCellModel(with: feed)
            cellModel.append(model)
        }
        self.cellViewModels = cellModel
     
    }
    
    func getCellAtRow(indexPath: IndexPath) -> NewsFeedCellModel {
        return cellViewModels[indexPath.row]
    }
    
    func displayFilteredFeed(filteredFeed: [NewsFeed]) {
        self.processFetchedData(newsFeed: filteredFeed)
    }
    
    func fetchFeedFromCache() {
        PersistanceManager.retreiveNewsFeed { result in
            switch result {
            case .success(let newsFeed):
                self.processFetchedData(newsFeed: newsFeed)
            case .failure:
                print("Error retreiving news feed when network offline ")
                
            }
        }
    }
}
