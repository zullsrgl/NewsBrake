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
    
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    private let apiKey = "8a103b3630444c6486498a1b4ac0e27e"
    private let country = "us"
    
    private  let parameters: [String: String] = [
        "apiKey": "8a103b3630444c6486498a1b4ac0e27e",
        "country": "us" ]
    
    func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        AF.request(baseURL, parameters: parameters) .validate().responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFilteredNews( for query: String, complation: @escaping(Result<[Article], Error>) -> Void){
          let searchpPrameters: [String: String] = [
            "apiKey": apiKey,
            "country": country,
            "q": query]
        
        AF.request(baseURL, parameters: searchpPrameters).validate().responseDecodable(of: NewsResponse.self){ response in
            switch response.result {
                case .success(let value):
                complation(.success(value.articles))
            case .failure(let error):
                print("getFilteredNews error: \(error)")
            }
        }
    }
}
