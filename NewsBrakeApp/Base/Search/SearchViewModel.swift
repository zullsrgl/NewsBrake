//
//  SearchViewModel.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 22.06.2025.
//
import Alamofire

protocol SearchViewModelDelegate: AnyObject {
    func didUpdateArticals(data: [Article])
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    func fetchNews() {
        APIManager.shared.getNews { [weak self] result in
            switch result {
            case.success(let articals):
                self?.delegate?.didUpdateArticals(data: articals)
            case.failure(let error):
                DispatchQueue.main.async {
                    print("error: \(error)")
                }
            }
        }
    }
    
    func fetchSearchNews(keyword: String) {
        APIManager.shared.getFilteredNews(for: keyword) { [weak self] result in
            switch result {
            case.success(let keyword):
                self?.delegate?.didUpdateArticals(data: keyword)
            case.failure(let error):
                print("error: \(error)")
            }
            
        }
    }
    
    
    func fetchCategory(category: String){
        APIManager.shared.getCetogryNews(for: category){ [weak self] result in
            switch result {
            case .success(let result):
                self?.delegate?.didUpdateArticals(data: result)
            case .failure(let err):
                print("error: \(err)")
            }
            
        }
    }
}

