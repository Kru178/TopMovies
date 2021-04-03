//
//  NetworkManager.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key="
//    let cache = NSCache<NSString, UIImage>()
    let apiKey = "8ffda756f7cae9fc0afbfbeae03373d4"
    let end = "&language=en-US&page="
    
    func getMovies(for page: Int, completed: @escaping (Result<MovieList, TDError>) -> Void) {
        let endpoint = baseUrl + apiKey
            + end + "\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
//            let string = String(data: data, encoding: .utf8)
//            print(string)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let list = try decoder.decode(MovieList.self, from: data)
                print("no error")
                print(list)
                completed(.success(list))
            } catch {
                print("data error")
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
//        let cacheKey = NSString(string: urlString)
//
//        if let image = cache.object(forKey: cacheKey) {
//            completed(image)
//            return
//        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [ weak self ] (data, response, error) in
            
            guard let self = self,
            error == nil,
            let response = response as? HTTPURLResponse, response.statusCode == 200,
            let data = data,
            let image = UIImage(data: data) else {
                completed(nil)
                return
            }
//            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}