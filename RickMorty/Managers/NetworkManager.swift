//
//  NetworkManager.swift
//  RickMorty
//
//  Created by Nodirbek on 14.04.2022.
//

import UIKit

protocol NetworManagerDelegate: AnyObject {
    func getData(completion: @escaping(Result<[ResultDataModel], NetworkError>)->Void)
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
    func getUser(with id: Int, completion: @escaping (Result<ResultDataModel, NetworkError>)->Void)
}

enum NetworkError:String, Error {
    case unknownError = "Unable to complete your request. Check your internet connection."
    case badUrl = "The data received from the server was invalid. Please try again."
}

struct Response: Codable {
    let info: Info
    let results: [ResultDataModel]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct ResultDataModel: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

final class NetworkManager {
    
    
    private func parseData(from data: Data) -> [ResultDataModel]? {
        let decoder = JSONDecoder()
        var dataModel: [ResultDataModel]?
        do {
            let result = try decoder.decode(Response.self, from: data)
            dataModel = result.results
        } catch {
            print(error.localizedDescription)
        }
        return dataModel
    }
    
}

extension NetworkManager: NetworManagerDelegate {
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = CacheManager.shared.getImage(for: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            CacheManager.shared.set(image: image, key: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    
    func getData(completion: @escaping(Result<[ResultDataModel], NetworkError>)->Void) {
        let session = URLSession.shared
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.unknownError))
            }
            
            if let data = data {
                if let result = self.parseData(from: data) {
                    completion(.success(result))
                }
                else {
                    completion(.failure(.unknownError))
                }
            }
        }
        task.resume()
    }

    func getUser(with id: Int, completion: @escaping (Result<ResultDataModel, NetworkError>)->Void){
        let session = URLSession.shared
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.unknownError))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badUrl))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknownError))
                return
            }
            do{
                let decoder = JSONDecoder()
                let character = try decoder.decode(ResultDataModel.self, from: data)
                completion(.success(character))
            } catch{
                completion(.failure(.unknownError))
            }
            
        }
        task.resume()

        
    }
    
}
