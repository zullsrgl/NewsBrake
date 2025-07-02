//
//  APIManager.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 22.06.2025.
//

import Alamofire
import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    private lazy var baseURL = "https://newsapi.org/v2/top-headlines"
    private lazy var apiKey = "8a103b3630444c6486498a1b4ac0e27e"
    private lazy var country = "us"
    
    
    private lazy var defaultParameter : [String: String] = {
        var parameters: [String: String] = [:]
        parameters["apiKey"] = apiKey
        parameters["country"] = country
        return parameters
    }()
    
    func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        AF.request(baseURL, parameters: defaultParameter).validate().responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.articles ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFilteredNews(for query: String,category: String?, complation: @escaping(Result<[Article], Error>) -> Void){
        
        var params = defaultParameter
        
        if !query.isEmpty{
            params["q"] = query
        }
        
        if let category = category, !category.isEmpty {
            params["category"] = category
        }
        
        AF.request(baseURL, parameters: params).validate().responseDecodable(of: NewsResponse.self){ response in
            switch response.result {
                
            case .success(let value):
                complation(.success(value.articles ?? []))
                
            case .failure(let error):
                print("getFilteredNews error: \(error)")
            }
        }
    }
}
