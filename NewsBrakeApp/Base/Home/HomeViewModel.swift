//
//  HomeViewModel.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit
import Alamofire

class HomeViewModel {
    var articals: [Article] = []
    var onUpdate: (() -> Void)?
    let url = "https://newsapi.org/v2/top-headlines"
    let parameters: [String: String] = [
        "apiKey": "a51868b7016e450a946d25f0f743ac69",
        "country": "us"
    ]
    
    func fetchNews() {
        AF.request(url, parameters: parameters).validate().responseDecodable(of: NewsResponse.self){ response in
            switch response.result {
                
            case .success(let newResponse):
                self.articals = newResponse.articles
                DispatchQueue.main.async {
                    self.onUpdate?()  
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
