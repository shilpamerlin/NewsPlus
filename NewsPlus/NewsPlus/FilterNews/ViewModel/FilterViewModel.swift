//
//  FilterViewModel.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-24.
//

import Foundation

class FilterViewModel {
    
    func filterNewsFeed(selectedType: String, completion: @escaping(Result<[NewsFeed]>) -> Void) {
        PersistanceManager.retreiveNewsFeed { result in
            switch result {
            case .success(let newsFeed):
                let filteredFeed = newsFeed.filter({ return $0.feedType == selectedType})
                completion(.success(filteredFeed))
            case .failure:
                completion(.failure(.decodeFailed))
            }
        }
    }
    
}
