//
//  SearchViewModel.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 22.06.2025.
//
import Alamofire

protocol SearchViewModelDelegate: AnyObject {
    func getData(data: [Article])
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate!
    
    func fetchNews() {
        APIManager.shared.getNews { [weak self] result in
            switch result {
            case.success(let articals):
                self?.delegate.getData(data: articals)
                
            case.failure(let error):
                DispatchQueue.main.async {
                    print("error: \(error)")
                }
            }
        }
    }
}

