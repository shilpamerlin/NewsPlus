//
//  PersistanceManager.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-24.
//

import Foundation

enum PersistanceManager {
    
    private static let defaults = UserDefaults.standard
    
    static func retreiveNewsFeed(completion: @escaping(Result<[NewsFeed]>) -> Void) {
        guard let newsFeedData = defaults.object(forKey: Constants.PersistanceKeys.newsFeed) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let newsFeed = try decoder.decode([NewsFeed].self, from: newsFeedData)
            completion(.success(newsFeed))
        } catch {
            completion(.failure(.decodeFailed))
        }
    }
    
    static func save(newsFeed: [NewsFeed]) {
        retreiveNewsFeed { result in
            switch result {
            case .success(let retreivedNewsFeed):
                if retreivedNewsFeed == newsFeed, !retreivedNewsFeed.isEmpty {
                    return
                }
                do {
                    let encoder = JSONEncoder()
                    let encodedNewsFeed = try encoder.encode(newsFeed)
                    defaults.set(encodedNewsFeed, forKey: Constants.PersistanceKeys.newsFeed)
                } catch {
                    print("Data saving failed")
                }
            case .failure(let error):
                print("Retreving data failed\(error)")
            }
        }
        
    }
}
