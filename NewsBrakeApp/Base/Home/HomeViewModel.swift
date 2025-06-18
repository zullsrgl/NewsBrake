//
//  HomeViewModel.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit
import Alamofire

protocol NewsDelegate: AnyObject {
    func didUpdateNews()
}

class HomeViewModel {
    var newsDelegate: NewsDelegate!
    let url = "https://newsapi.org/v2/top-headlines"
    let parameters: [String: String] = [
        "apiKey": "a51868b7016e450a946d25f0f743ac69",
        "country": "us"
    ]
    var articals: [Article] = []{
        didSet {
            DispatchQueue.main.async {
                self.newsDelegate.didUpdateNews()
            }
        }
    }
    
    func fetchNews() {
        AF.request(url, parameters: parameters).validate().responseDecodable(of: NewsResponse.self){ response in
            switch response.result {
                
            case .success(let newResponse):
                self.articals = newResponse.articles
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
