//
//  SearchViewModel.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 22.06.2025.
//
import Alamofire

protocol SearchDelegate: AnyObject {
    func didUpload()
}

class SearchViewModel {
    
    var searchDelegate: SearchDelegate!
    var articals: [Article] = []{
        didSet{
            searchDelegate.didUpload()
        }
    }
    
    func fetchNews() {
        APIManager.shared.getNews { [weak self] result in
            switch result {
            case.success(let articals):
                self?.articals = articals
                
            case.failure(let error):
                DispatchQueue.main.async {
                    print("error: \(error)")
                }
            }
        }
    }
}

