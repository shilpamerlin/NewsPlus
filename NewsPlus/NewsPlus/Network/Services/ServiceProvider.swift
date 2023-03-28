//
//  ServiceProvider.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
    case decodeFailed
}

/// Class that will actually handle the API calls with a URLSession and resturn response
class ServiceProvider<T: EndPointType> {
    // MARK: - Properties
    var urlSession = URLSession.shared
    
}

// MARK: - Public funcs
extension ServiceProvider {
    
    /// Performs API request which is called by any service class
    ///
    /// - Parameters:
    ///     - endPoint: any service that confirms to Service protocol
    ///     - completion: Request completion Handler, will be returning Data
    func loadService(endPoint: T, completion: @escaping(Result<Data>) -> Void) {
        let urlRequest = makeRequest(with: endPoint)
        executeRequest(urlRequest, completion: completion)
    }
    
    /// Performs API request which is called by any service class
    ///
    /// - Parameters:
    ///     - endPoint: any service that confirms to Service protocol
    ///     - decodeType: decodable object.type
    ///     - completion: Request completion Handler
    func load<U>(
        endPoint: T,
        decodeType: U.Type,
        completion:@escaping(Result<U>)
        -> Void) where U: Decodable {
            
            let urlRequest = makeRequest(with: endPoint)
            executeRequest(urlRequest) { result in
                
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(decodeType, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(.decodeFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
}

// MARK: - Private functions
extension ServiceProvider {
    
    private func makeRequest(with endPoint: EndPointType) -> URLRequest {
        
        let urlString = endPoint.baseURL + endPoint.path
        let urlComponents =  URLComponents(string: urlString)
        
        guard let url = urlComponents?.url else {
            fatalError("URL is incorrect")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func executeRequest(
        _ request: URLRequest,
        completion:@escaping(Result<Data>)
        -> Void) {
            
            urlSession.dataTask(with: request) { data, response, error in
                
                if error != nil {
                    completion(.failure(.requestFailed))
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let data = data {
                            completion(.success(data))
                        }
                    } else {
                        completion(.failure(.requestFailed))
                    }
                }
            }.resume()
        }
}
