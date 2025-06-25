//
//  HomeViewModel.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit
import Alamofire

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateNews(articals: [Article])
}

final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    func fetchNews() {
        APIManager.shared.getNews { [weak self] result in
            switch result {
            case.success(let articals):
                self?.delegate?.didUpdateNews(articals: articals)
            case.failure(let error):
                DispatchQueue.main.async {
                    print("error: \(error)")
                }
            }
        }
    }
}
