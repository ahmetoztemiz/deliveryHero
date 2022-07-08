//
//  BaseService.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

protocol BaseServiceProtocol: AnyObject {
    func responseService <T: Decodable> (params: [(urlParameters, String)]?,
                                         additionalURL: String?,
                                         completion: @escaping ((T?) -> Void))
    
    func responseService <T: Decodable> (params: [(urlParameters, String)]?,
                                         additionalURL: String?,
                                         completion: @escaping (([T]?) -> Void))
}

extension BaseServiceProtocol {
    func responseService <T: Decodable> (params: [(urlParameters, String)]? = nil,
                                         additionalURL: String? = nil,
                                         completion: @escaping ((T?) -> Void)) {
        return responseService(params: params, additionalURL: additionalURL, completion: completion)
    }
    
    func responseService <T: Decodable> (params: [(urlParameters, String)]? = nil,
                                         additionalURL: String? = nil,
                                         completion: @escaping (([T]?) -> Void)) {
        return responseService(params: params, additionalURL: additionalURL, completion: completion)
    }
}

enum urlParameters: String {
    case imageBase = "https://image.tmdb.org/t/p/w500"
    case popularMovie = "movie/popular"
    case multiSearch = "search/multi"
    case apiKey = "api_key"
    case key = "00ffab1ba4de79a8d1cfec5af4bb1534"
    case page
    case query
    case language
}

class BaseService: BaseServiceProtocol {
    private func getURLComponents(params: [(type: urlParameters, value: String)]?,
                                  additionalURL: String?) -> URL? {
        var baseURL = "https://api.themoviedb.org/3/"
        if let additionalURL = additionalURL {
            baseURL += additionalURL
        }
        
        var component = URLComponents(string: baseURL)
        if let params = params {
            let queryItems = params.map {
                URLQueryItem(name: $0.type.rawValue, value: $0.value)
            }
            component?.queryItems = queryItems
        }
        
        return component?.url
    }
    
    func responseService <T: Decodable> (params: [(urlParameters, String)]?,
                                         additionalURL: String?,
                                         completion: @escaping ((T?) -> Void)) {
        
        guard let url = getURLComponents(params: params, additionalURL: additionalURL) else { return }
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error { completion(nil) }
            guard let data = data else { return }
            
            if let dataModel = try? JSONDecoder().decode(T.self, from: data) {
                completion(dataModel)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func responseService <T: Decodable> (params: [(urlParameters, String)]?,
                                         additionalURL: String?,
                                         completion: @escaping (([T]?) -> Void)) {
        
        guard let url = getURLComponents(params: params, additionalURL: additionalURL) else { return }
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error { completion(nil) }
            guard let data = data else { return }
            
            if let dataModel = try? JSONDecoder().decode([T].self, from: data) {
                completion(dataModel)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func downloadImage(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {

                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
