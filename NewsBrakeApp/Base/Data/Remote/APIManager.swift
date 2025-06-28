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
    private  let parameters: [String: String] = [
        "apiKey": "a51868b7016e450a946d25f0f743ac69",
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
}
